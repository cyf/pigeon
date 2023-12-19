import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  printDebugLog('onDidReceiveBackgroundNotificationResponse: notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    printDebugLog('notification action tapped with input: ${notificationResponse.input}');
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
      printDebugLog('onDidReceiveNotificationResponse: notification(${notificationResponse.id})'
          ' action tapped: ${notificationResponse.actionId} with'
          ' payload: ${notificationResponse.payload}');
      if (notificationResponse.input?.isNotEmpty ?? false) {
        // ignore: avoid_print
        printDebugLog('notification action tapped with input: ${notificationResponse.input}');
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

Future<void> initApp() async {
  final packageInfo = await PackageInfo.fromPlatform();
  AppManager.instance
    ..version = packageInfo.version
    ..prodVersion = packageInfo.version
        .replaceAll(RegExp(r'\+[0-9-a-z]+'), StringUtil.empty)
    ..buildNumber = packageInfo.buildNumber;
}
