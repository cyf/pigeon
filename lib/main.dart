import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homing_pigeon/app/bloc_observer.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();

  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await FirebaseMessaging.instance.requestPermission();

  final onError = FlutterError.onError;
  FlutterError.onError = (details) async {
    onError?.call(details);
    if (kReleaseMode) {
      await FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    if (!kReleaseMode) {
      log(error.toString(), stackTrace: stackTrace);
    } else {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    }
    return true;
  };

  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }

  await initApp();
  await SpUtil.getInstance();

  runApp(const AppView());
}

Future<void> initApp() async {
  final packageInfo = await PackageInfo.fromPlatform();
  AppManager.instance
    ..version = packageInfo.version
    ..buildNumber = packageInfo.buildNumber;
}
