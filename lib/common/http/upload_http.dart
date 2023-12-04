import 'package:flutter/foundation.dart';
import 'package:homing_pigeon/common/http/base_http.dart';
import 'package:homing_pigeon/common/http/interceptors/interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final UploadHttp uploadHttp = UploadHttp();

class UploadHttp extends BaseHttp {
  UploadHttp();

  @override
  void init() {
    // do something
    interceptors.addAll([
      UploadInterceptor(),
      if (!kReleaseMode) ...[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ],
    ]);
  }
}
