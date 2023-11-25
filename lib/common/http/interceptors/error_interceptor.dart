import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/http/constants/code.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 没有网络
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: Code.errorHandleFunction(
            Code.networkError,
            'Network Error',
          ),
        ),
      );
    }
    super.onRequest(options, handler);
  }
}
