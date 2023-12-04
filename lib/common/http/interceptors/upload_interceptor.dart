import 'dart:io';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/http/constants/code.dart';

class UploadInterceptor extends InterceptorsWrapper {
  UploadInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options
      ..connectTimeout =
          const Duration(seconds: Constants.timeOut * 1000) // 60s
      ..receiveTimeout = const Duration(seconds: Constants.timeOut * 1000)
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! <= 500;
      }
      ..headers.addAll(Constants.uploadHeaders);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (![200, 204].contains(response.statusCode)) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: Code.errorHandleFunction(
            response.statusCode,
            response.statusMessage,
          ),
        ),
      );
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Code.errorHandleFunction(
      HttpStatus.internalServerError,
      err.message,
    );
    super.onError(err, handler);
  }
}
