import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';

class HpHeaders {
  static const _encryptDefUrls = [''];

  static const _encryptKeys = ['password', 'newPassword', 'oldPassword'];

  static String _mapToUrlString(Map<String, dynamic> params) {
    final sortedMap = SplayTreeMap<String, dynamic>.from(params);
    final urlString = StringBuffer();
    sortedMap.forEach((key, value) {
      urlString.write('&$key=$value');
    });
    return urlString.isNotEmpty
        ? urlString.toString().substring(1)
        : urlString.toString();
  }

  static String _encodeParametersMd5(
    Map<String, dynamic> params,
    String signKey,
  ) {
    final urlString = _mapToUrlString(params);
    final content = const Utf8Encoder().convert(urlString + signKey);
    final digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static RequestOptions encodeRequestData(RequestOptions options) {
    final path = options.path;
    if (_encryptDefUrls.contains(path)) {
      final method = options.method.toUpperCase();
      if (method == 'GET') {
        return _encodeGetData(options);
      } else if (method == 'POST') {
        return _encodePostData(options);
      }
    }
    return options;
  }

  static RequestOptions _encodeGetData(RequestOptions options) {
    final parameters = options.queryParameters;
    return options..queryParameters.addAll(_getEncryptKey(parameters));
  }

  static RequestOptions _encodePostData(RequestOptions options) {
    final data = options.data;
    if (data != null && data is Map) {
      return options..data = _getEncryptKey(data as Map<String, dynamic>);
    }
    return options;
  }

  static Map<String, dynamic> _getEncryptKey(Map<String, dynamic> map) {
    for (final key in map.keys) {
      if (_encryptKeys.contains(key)) {
        map[key] = _getEncrypt(map[key] as String);
      }
    }
    return map;
  }

  static String _getEncrypt(String content) {
    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(Constants.cryptoAESKey),
        mode: AESMode.cbc,
      ),
    );
    final encrypted =
        encrypter.encrypt(content, iv: IV.fromUtf8(Constants.cryptoAESIV));
    return encrypted.base64;
  }

  static Map<String, dynamic> encryptRequestHeaders(RequestOptions options) {
    final token = SpUtil.getString(Keys.tokenKey);
    return {
      'x-sign': _encodeParametersMd5(
        options.queryParameters,
        Constants.signKey,
      ),
      'x-version': AppManager.instance.version,
      'x-token':
          StringUtil.isNotBlank(token) ? 'Bearer $token' : StringUtil.empty,
      'x-channel': Platform.isIOS
          ? 'MOBILE_IOS_HOMING_PIGEON'
          : 'MOBILE_ANDROID_HOMING_PIGEON',
      // TODO(kjxbyz): change locale
      'x-locale': 'en',
    };
  }

  static Map<String, dynamic> fetchCommonParameters() {
    return {
      'datestamp': DateTime.now().millisecondsSinceEpoch,
      'nonce': _randomStrings(),
    };
  }

  static String _randomStrings({int length = 10}) {
    final random = Random();
    const availableChars = 'abcdefghijklmnopqrstuvwxyz';
    final randomString = List.generate(
      length,
      (index) => availableChars[random.nextInt(availableChars.length)],
    ).join();

    return randomString;
  }
}