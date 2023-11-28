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

  static String signKey = StringUtil.getValue(dotenv.env['SIGN_KEY']);
  static String cryptoAESKey =
  StringUtil.getValue(dotenv.env['CRYPTO_AES_KEY']);
  static String cryptoAESIV = StringUtil.getValue(dotenv.env['CRYPTO_AES_IV']);

  static String sentryDsn = StringUtil.getValue(dotenv.env['SENTRY_DSN']);

  static bool sentryEnabled = StringUtil.isNotBlank(sentryDsn);
}
