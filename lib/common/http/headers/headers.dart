import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:deep_collection/deep_collection.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:uuid/uuid.dart';

class HpHeaders {
  static const _uuid = Uuid();

  static const _encryptDefUrls = [''];

  static const _encryptKeys = ['password', 'newPassword', 'oldPassword'];

  static String _mapToUrlString(Map<String, dynamic> params) {
    final sortedMap = SortedMap.from(params);
    final urlString = StringBuffer();
    sortedMap.forEach((key, value) {
      if (value is List) {
        value.deepSort().forEach((element) {
          urlString.write('&$key=$element');
        });
      } else {
        urlString.write('&$key=$value');
      }
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
      'x-version': AppManager.instance.prodVersion,
      'x-token':
          StringUtil.isNotBlank(token) ? 'Bearer $token' : StringUtil.empty,
      'x-channel': Platform.isIOS ? 'MOBILE_IOS' : 'MOBILE_ANDROID',
      'x-flavor': AppConfig.shared.flavor.name,
      'x-locale': 'en',
    };
  }

  static Map<String, dynamic> fetchCommonParameters() {
    return {
      'datestamp': DateTime.now().millisecondsSinceEpoch,
      'nonce': _uuid.v4(),
    };
  }
}
