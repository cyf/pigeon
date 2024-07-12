import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pigeon/common/constants/constants.dart';
import 'package:pigeon/common/http/interceptors/interceptors.dart';
import 'package:sentry_dio/sentry_dio.dart';

// 必须是顶层函数
dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

Future<dynamic> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp with DioMixin implements Dio {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
    options = BaseOptions();
    httpClientAdapter = HttpClientAdapter();
    ErrorInterceptor();
    init();
    if (Constants.sentryEnabled) {
      addSentry();
    }
  }

  void init();
}
