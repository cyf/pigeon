import 'dart:async';

import 'package:aliyun_oss_flutter/aliyun_oss_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/bloc_observer.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/main_common.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/data/latest_10y.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await dotenv.load();

  AppConfig.create(
    flavor: Flavor.external,
  );

  if (Constants.sentryEnabled && kReleaseMode) {
    await SentryFlutter.init(
          (options) {
        options
          ..dsn = Constants.sentryDsn
          ..tracesSampleRate = 1.0;
      },
    );
  }

  if (Constants.ossEnabled) {
    OSSClient.init(
      endpoint: Constants.endpoint,
      bucket: Constants.bucket,
      credentials: () async {
        return Credentials(
          accessKeyId: Constants.accessKeyId,
          accessKeySecret: Constants.accessKeySecret,
        );
      },
    );
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

  await Firebase.initializeApp();
  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await FirebaseMessaging.instance.requestPermission();

  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }

  await initApp();
  await SpUtil.getInstance();

  runApp(const App());
}
