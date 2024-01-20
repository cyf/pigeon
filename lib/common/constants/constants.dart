import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';

/// Constants
class Constants {
  static String apiPrefix = StringUtil.getValue(dotenv.env['API_PREFIX']);

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

  static String signKey = StringUtil.getValue(dotenv.env['SIGN_KEY']);
  static String cryptoAESKey =
      StringUtil.getValue(dotenv.env['CRYPTO_AES_KEY']);
  static String cryptoAESIV = StringUtil.getValue(dotenv.env['CRYPTO_AES_IV']);

  /// oss
  static String region = StringUtil.getValue(dotenv.env['ASSETS_REGION']);
  static String endpoint = StringUtil.getValue(dotenv.env['ASSETS_ENDPOINT']);
  static String bucket = StringUtil.getValue(dotenv.env['ASSETS_BUCKET']);
  static String accessKeyId =
      StringUtil.getValue(dotenv.env['ASSETS_ACCESS_KEY_ID']);
  static String accessKeySecret =
      StringUtil.getValue(dotenv.env['ASSETS_ACCESS_KEY_SECRET']);
  static String host = StringUtil.getValue(
    dotenv.env['ASSETS_HOST'],
    defaultVal: 'https://$bucket.$region.$endpoint',
  );
  static bool ossEnabled = StringUtil.isNotBlank(region) &&
      StringUtil.isNotBlank(endpoint) &&
      StringUtil.isNotBlank(bucket) &&
      StringUtil.isNotBlank(accessKeyId) &&
      StringUtil.isNotBlank(accessKeySecret);

  static String sentryDsn = StringUtil.getValue(dotenv.env['SENTRY_DSN']);
  static bool sentryEnabled = StringUtil.isNotBlank(sentryDsn);
}
