// Package imports:
import 'package:dio/dio.dart';
import 'package:sentry_dio/sentry_dio.dart';

// Project imports:
import 'package:pigeon/common/constants/constants.dart';
import 'package:pigeon/common/http/interceptors/interceptors.dart';

abstract class BaseHttp with DioMixin implements Dio {
  BaseHttp() {
    /// 初始化 加入app通用处理
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
