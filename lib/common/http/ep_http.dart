import 'package:flutter/foundation.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/http/base_http.dart';
import 'package:homing_pigeon/common/http/interceptors/base_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final EpHttp epHttp = EpHttp();

class EpHttp extends BaseHttp {
  EpHttp();

  @override
  void init() {
    // do something
    interceptors.addAll([
      BaseInterceptor(Constants.apiPrefix),
      if (!kReleaseMode) ...[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ],
    ]);
  }
}
