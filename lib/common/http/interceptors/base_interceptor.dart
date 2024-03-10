import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/http/constants/code.dart';
import 'package:homing_pigeon/common/http/headers/headers.dart';
import 'package:homing_pigeon/common/models/models.dart';

class BaseInterceptor extends InterceptorsWrapper {
  BaseInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accept = options.headers['Accept'] as String? ?? 'application/json';
    final contentType = options.headers['Content-Type'] as String? ??
        'application/json; charset=utf-8';
    final headers = <String, String>{
      'Accept': accept,
      'Content-Type': contentType,
    };
    final queryParameters = HpHeaders.fetchCommonParameters()
      ..addAll(
        options.queryParameters..removeWhere((key, value) => value == null),
      );
    options.queryParameters = queryParameters;

    /// 去除post请求中字段值为null的参数
    final data = options.data;
    if (data != null) {
      if (data is Map) {
        options.data = data..removeWhere((key, value) => value == null);
      } else if (data is List) {
        options.data = data.whereNotNull().map((element) {
          return element is Map
              ? (element..removeWhere((key, value) => value == null))
              : element;
        }).toList();
      }
    }

    final opts = HpHeaders.encodeRequestData(options);
    opts
      ..baseUrl = Constants.apiPrefix
      ..connectTimeout =
          const Duration(seconds: Constants.timeOut * 1000) // 60s
      ..receiveTimeout = const Duration(seconds: Constants.timeOut * 1000)
      // ..queryParameters = queryParameters
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! <= 500;
      }
      ..headers.addAll(headers)
      ..headers.addAll(HpHeaders.encryptRequestHeaders(opts));
    super.onRequest(opts, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (![200, 201].contains(response.statusCode)) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: Code.errorHandleFunction(
            response.statusCode?.toString(),
            response.statusMessage,
          ),
        ),
      );
    }

    final res = HpResponse.fromJson(
      response.data as Map<String, dynamic>,
      (json) => json,
    );

    if (res.code != 0) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: Code.errorHandleFunction(res.code?.toString(), res.msg),
        ),
      );
    }

    response.data = res.data;
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Code.errorHandleFunction(
      HttpStatus.internalServerError.toString(),
      err.message,
    );
    super.onError(err, handler);
  }
}
