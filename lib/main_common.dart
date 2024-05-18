import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_aliyun_oss/flutter_aliyun_oss.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homing_pigeon/app/bloc_observer.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/i18n/i18n.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:jpush_flutter2/jpush_flutter2.dart';
import 'package:logging/logging.dart';
import 'package:minio_flutter/minio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:timezone/data/latest_10y.dart' as tz;

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> reportErrorAndLog(FlutterErrorDetails details) async {
  printErrorStackLog(details.exception, details.stack);
  if (Constants.sentryEnabled && kReleaseMode) {
    await Sentry.captureException(details.exception, stackTrace: details.stack);
  }
}

FlutterErrorDetails makeErrorDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

Future<void> runMainApp() async {
  tz.initializeTimeZones();
  await SpUtil.getInstance();
  // app version / build number
  await initApp();

  Logger.root.level =
      kReleaseMode ? Level.OFF : Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}: ${record.time}: ${record.message}');
  });

  if (Constants.sentryEnabled && kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = Constants.sentryDsn
          ..tracesSampleRate = 1.0
          ..profilesSampleRate = 1.0
          ..attachThreads = true
          ..enableWindowMetricBreadcrumbs = true
          ..addIntegration(LoggingIntegration(minEventLevel: Level.INFO))
          ..sendDefaultPii = true
          ..reportSilentFlutterErrors = true
          ..attachScreenshot = true
          ..screenshotQuality = SentryScreenshotQuality.low
          ..attachViewHierarchy = true
          ..debug = kDebugMode
          ..spotlight = Spotlight(enabled: true)
          ..enableTimeToFullDisplayTracing = true
          ..enableMetrics = true
          ..maxRequestBodySize = MaxRequestBodySize.always
          ..maxResponseBodySize = MaxResponseBodySize.always
          ..navigatorKey = AppNavigator.key;
      },
    );
  }

  // initialize with the right locale
  LocaleSettings.useDeviceLocale();

  // TODO(kjxbyz): FIXME: upgrade socket_io_client to 3.0.0
  final socket = socket_io.io(
    Constants.wsPrefix,
    socket_io.OptionBuilder().setTransports(['websocket', 'polling']).build(),
  );

  socket
    ..onConnect((dynamic data) {
      printDebugLog('connect: $data');
      Fluttertoast.showToast(msg: 'Connected', gravity: ToastGravity.BOTTOM);
      socket.emitWithAck(
        'hello2',
        'test',
        ack: (dynamic data) => printDebugLog('hello2 ack: $data'),
      );
    })
    ..onConnectError((dynamic data) => printErrorLog('connect error: $data'))
    ..on('exception', (dynamic data) => printErrorLog('exception: $data'))
    ..onReconnectAttempt(
      (dynamic data) => printDebugLog('reconnect attempt: $data'),
    )
    ..onReconnect((dynamic data) {
      printDebugLog('reconnect: $data');
      Fluttertoast.showToast(msg: 'Reconnected', gravity: ToastGravity.BOTTOM);
    })
    ..onReconnectError(
      (dynamic data) => printDebugLog('reconnect error: $data'),
    )
    ..onReconnectFailed(
      (dynamic data) => printDebugLog('reconnect failed: $data'),
    )
    ..onDisconnect((dynamic data) => printDebugLog('disconnect: $data'))
    ..onError((dynamic data) => printErrorLog('error: $data'));

  if (Constants.ossEnabled) {
    if (AppConfig.shared.isExternal) {
      Minio.init(
        endPoint: Constants.endpoint,
        accessKey: Constants.accessKeyId,
        secretKey: Constants.accessKeySecret,
        region: Constants.region,
      );
    } else if (AppConfig.shared.isInternal) {
      OSSClient.init(
        endpoint: '${Constants.region}.${Constants.endpoint}',
        bucket: Constants.bucket,
        credentials: () async {
          return Credentials(
            accessKeyId: Constants.accessKeyId,
            accessKeySecret: Constants.accessKeySecret,
          );
        },
      );
    }
  }

  final onError = FlutterError.onError;
  FlutterError.onError = (details) async {
    onError?.call(details);
    await reportErrorAndLog(details);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    reportErrorAndLog(makeErrorDetails(error, stackTrace));
    return true;
  };

  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;

  if (AppConfig.shared.isExternal) {
    // TODO(kimmy): add app push service
  } else if (AppConfig.shared.isInternal) {
    await JPushFlutter.setDebugMode(debugMode: kDebugMode);
  }

  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }

  Widget child = const App();
  if (Constants.sentryEnabled && kReleaseMode) {
    child = SentryWidget(
      child: DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: child,
      ),
    );
  }

  runApp(TranslationProvider(child: child));
}

Future<void> initApp() async {
  final packageInfo = await PackageInfo.fromPlatform();
  AppManager.instance
    ..version = packageInfo.version
    ..buildNumber = packageInfo.buildNumber;
}
