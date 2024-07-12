import 'package:dio/dio.dart';
import 'package:pigeon/common/exception/exception.dart';
import 'package:pigeon/common/logger/logger.dart';

typedef VoidRequestedExceptionCallback = void Function(
  String? code,
  String? msg,
);

class ErrorHandler {
  static void handle(
    Exception error, {
    StackTrace? stackTrace,
    VoidRequestedExceptionCallback? postProcessor,
  }) {
    printErrorLog(error, stackTrace: stackTrace);
    if (postProcessor != null) {
      final exception = error is DioException
          ? RequestedException(error.error)
          : RequestedException(error.toString());
      final isEpError = error is DioException && error.error is HpError;
      final code = isEpError ? (error.error! as HpError).code : null;
      final msg = isEpError ? (error.error! as HpError).msg : exception.msg;
      postProcessor.call(code, msg);
    }
  }
}
