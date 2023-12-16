import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:aliyun_oss_flutter/aliyun_oss_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homing_pigeon/app/bloc_observer.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/data/latest_10y.dart' as tz;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log('Handling a background message ${message.messageId}');
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  log('onDidReceiveBackgroundNotificationResponse: notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    log('notification action tapped with input: ${notificationResponse.input}');
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
      log('onDidReceiveNotificationResponse: notification(${notificationResponse.id})'
          ' action tapped: ${notificationResponse.actionId} with'
          ' payload: ${notificationResponse.payload}');
      if (notificationResponse.input?.isNotEmpty ?? false) {
        // ignore: avoid_print
        log('notification action tapped with input: ${notificationResponse.input}');
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await FirebaseMessaging.instance.requestPermission();

  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }

  await initApp();
  await SpUtil.getInstance();

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
