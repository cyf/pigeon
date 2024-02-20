import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:jpush_flutter2/jpush_flutter2.dart';

void initJPush() {
  if (AppConfig.shared.isInternal) {
    AppManager.instance.jPushInitialized = true;
    JPushFlutter.setMethodCallHandler((call) async {
      printDebugLog('[method]: ${call.method}, ${call.arguments}');
      if (call.method == 'notificationClick' &&
          call.arguments != null &&
          StringUtil.isNotBlank(call.arguments.toString())) {
        try {
          // final dataJson =
          // jsonDecode(call.arguments!.toString()) as Map<String, dynamic>?;

          /// templateKey 是类型
          /// expertInfoPass  经营信息认证审核被平台运营通过后
          /// expertInfoRefuse  经营信息认证审核被平台运营拒绝后
          /// expertBizPass 类别认证审核被平台运营在后台被通过后
          /// expertBizRefuse 某类别认证审核被平台运营拒绝后
          ///
          /// templateKey=expertBizRefuse这个类型
          /// 多了几个变量
          /// bizSubName 服务名字
          /// bizSubId 服务编号
          /// expertsServiceId 专家服务关联id
          // final extras = dataJson?['extras'] as Map<String, dynamic>?;
          // final userId = extras?['userId'];
          // final context = AppNavigator.key.currentContext!;
        } on Exception catch (error) {
          printErrorLog(error);
        }
      }
    });

    JPushFlutter.init(
      Constants.jPushNotificationKey,
      Platform.isAndroid ? 'developer-default' : 'app-store',
    ).then((value) {
      Future.delayed(const Duration(seconds: 5), () async {
        if (kDebugMode) {
          final registrationID = await JPushFlutter.getRegistrationID();
          print('registrationID: $registrationID');
        }

        final userId = SpUtil.getString(Keys.userIdKey);
        await JPushFlutter.setAlias(0, userId);
      });
    });
  }
}

Future<void> initFirebase() async {
  if (AppConfig.shared.isExternal) {
    AppManager.instance.firebaseInitialized = true;
    // final userId = SpUtil.getString(Keys.userIdKey);
    // FirebaseMessaging.onMessage.listen(showFirebaseNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      printDebugLog(
        '[FirebaseMessaging] onMessageOpenedApp: ${message.toMap()}',
      );
      final extras = message.data;
      navigateToPage(extras);
    });
    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        printDebugLog(
          '[FirebaseMessaging] getInitialMessage: ${message.toMap()}',
        );
        final extras = message.data;
        navigateToPage(extras);
      }
    });

    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print('FCM Token: $token');
      }
      if (StringUtil.isNotBlank(token)) {
        await SpUtil.putString(Keys.fcmTokenKey, token!);
        // await LoginApi.saveFcmToken(
        //   data: {
        //     'userId': userId,
        //     'token': token,
        //   },
        //   onSuccess: (dynamic data) => true,
        // );
      }
    } on Exception catch (error) {
      printErrorLog(error);
    }
  }
}

void navigateToPage(Map<String, dynamic> extras) {
  // final userId = extras['userId'];
  // final context = AppNavigator.key.currentContext!;
}
