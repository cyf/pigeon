import 'dart:convert';
import 'dart:io';

import 'package:aliyun_oss/aliyun_oss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homing_pigeon/app/bloc_observer.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/utils/log_util.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:minio/minio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:timezone/data/latest_10y.dart' as tz;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  printDebugLog('Handling a background message ${message.messageId}');
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  printDebugLog(
      'onDidReceiveBackgroundNotificationResponse: notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    printDebugLog(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const initializationSettingsAndroid = AndroidInitializationSettings('splash');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  const initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      printDebugLog(
          'onDidReceiveNotificationResponse: notification(${notificationResponse.id})'
          ' action tapped: ${notificationResponse.actionId} with'
          ' payload: ${notificationResponse.payload}');
      if (notificationResponse.input?.isNotEmpty ?? false) {
        // ignore: avoid_print
        printDebugLog(
          'notification action tapped with input: ${notificationResponse.input}',
        );
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  final notification = message.notification;
  final android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,

          /// add a proper drawable resource to android, for now using
          /// one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void reportErrorAndLog(FlutterErrorDetails details) {
  printErrorStackLog(details.exception, details.stack);
}

FlutterErrorDetails makeErrorDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

Future<void> runMainApp() async {
  tz.initializeTimeZones();
  await dotenv.load();

  if (Constants.sentryEnabled && kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = Constants.sentryDsn
          ..tracesSampleRate = 1.0;
      },
    );
  }

  await SpUtil.getInstance();
  await LogUtil.getInstance();

  final socket = socket_io.io(
    '${Constants.apiPrefix}/ws',
    socket_io.OptionBuilder()
        .setPath('/homing-pigeon/socket.io/')
        .setTransports(['websocket', 'polling']).setExtraHeaders(
      {'foo': 'bar'},
    ).build(),
  );

  socket
    ..onConnecting((dynamic data) => printDebugLog('connecting'))
    ..onConnect((_) {
      printDebugLog('connect');
      Fluttertoast.showToast(msg: 'Connected', gravity: ToastGravity.BOTTOM);
      socket.emit('hello2', 'test');
    })
    ..onConnectError(printErrorLog)
    ..onConnectTimeout(printErrorLog)
    ..on('hello2', (dynamic data) => printDebugLog('hello2: $data'))
    ..on('exception', (dynamic data) => printErrorLog('error: $data'))
    ..onReconnectAttempt((dynamic data) => printDebugLog('reconnect attempt'))
    ..onReconnecting((dynamic data) => printDebugLog('reconnecting'))
    ..onReconnect((_) {
      printDebugLog('connect');
      Fluttertoast.showToast(msg: 'Connected', gravity: ToastGravity.BOTTOM);
    })
    ..onReconnectError(printErrorLog)
    ..onReconnectFailed(printErrorLog)
    ..onDisconnect((_) => printDebugLog('disconnect'))
    ..onError(printErrorLog);

  if (Constants.ossEnabled) {
    if (AppConfig.shared.isExternal) {
      Minio.init(
        endPoint: '${Constants.region}.${Constants.endpoint}',
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
  FlutterError.onError = (details) {
    onError?.call(details);
    reportErrorAndLog(details);
  };

  /// Pass all uncaught asynchronous errors
  /// that aren't handled by the Flutter Framework to Sentry
  PlatformDispatcher.instance.onError = (error, stack) {
    reportErrorAndLog(makeErrorDetails(error, stack));
    return true;
  };

  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;

  if (AppConfig.shared.isExternal) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await setupFlutterNotifications();
    await FirebaseMessaging.instance.requestPermission();
  } else if (AppConfig.shared.isInternal) {
    await JPushFlutter.setDebugMode(debugMode: kDebugMode);
  }

  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }

  await initApp();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(
      true,
    );

    final swAvailable = await AndroidWebViewFeature.isFeatureSupported(
      AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE,
    );
    final swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
      AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST,
    );

    if (swAvailable && swInterceptAvailable) {
      final serviceWorkerController = AndroidServiceWorkerController.instance();

      await serviceWorkerController.setServiceWorkerClient(
        AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ),
      );
    }
  }

  runApp(const App());
}

Future<void> initApp() async {
  final packageInfo = await PackageInfo.fromPlatform();
  AppManager.instance
    ..version = packageInfo.version
    ..prodVersion = packageInfo.version
        .replaceAll(RegExp(r'\+[0-9-a-z]+'), StringUtil.empty)
    ..buildNumber = packageInfo.buildNumber;
}
