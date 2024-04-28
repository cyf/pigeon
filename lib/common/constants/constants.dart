import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';

/// Constants
class Constants {
  static const int days = 7;

  static const int timeOut = 60;

  static const int pageSize = 20;

  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=utf-8',
  };

  static const Map<String, String> uploadHeaders = {
    'Accept': '*/*',
    'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
  };

  // request
  static String apiPrefix = const String.fromEnvironment('API_PREFIX');
  static String youtubeApiPrefix = 'https://www.googleapis.com';
  static String wsPrefix = const String.fromEnvironment('WS_PREFIX');
  static String signKey = const String.fromEnvironment('SIGN_KEY');
  static String cryptoAESKey = const String.fromEnvironment('CRYPTO_AES_KEY');
  static String cryptoAESIV = const String.fromEnvironment('CRYPTO_AES_IV');

  // jpush
  static String jPushNotificationKey = Platform.isAndroid && kDebugMode
      ? const String.fromEnvironment('JPUSH_APP_KEY_ANDROID_DEV')
      : const String.fromEnvironment('JPUSH_APP_KEY');

  // google sign in
  static String googleOAuth2ClientId = Platform.isAndroid
      ? const String.fromEnvironment('GOOGLE_OAUTH2_CLIENT_ID_ANDROID')
      : const String.fromEnvironment('GOOGLE_OAUTH2_CLIENT_ID_IOS');

  // youtube
  static String youtubeApiKey = Platform.isAndroid
      ? const String.fromEnvironment('YOUTUBE_API_KEY_ANDROID')
      : const String.fromEnvironment('YOUTUBE_API_KEY_IOS');

  /// oss
  static String region = const String.fromEnvironment('ASSETS_REGION');
  static String endpoint = const String.fromEnvironment('ASSETS_ENDPOINT');
  static String bucket = const String.fromEnvironment('ASSETS_BUCKET');
  static String accessKeyId =
      const String.fromEnvironment('ASSETS_ACCESS_KEY_ID');
  static String accessKeySecret =
      const String.fromEnvironment('ASSETS_ACCESS_KEY_SECRET');
  static String host = String.fromEnvironment(
    'ASSETS_HOST',
    defaultValue: 'https://$bucket.$region.$endpoint',
  );
  static bool ossEnabled = StringUtil.isNotBlank(region) &&
      StringUtil.isNotBlank(endpoint) &&
      StringUtil.isNotBlank(bucket) &&
      StringUtil.isNotBlank(accessKeyId) &&
      StringUtil.isNotBlank(accessKeySecret);

  // crash report
  static String sentryDsn = const String.fromEnvironment('SENTRY_DSN');
  static bool sentryEnabled = StringUtil.isNotBlank(sentryDsn);
}
