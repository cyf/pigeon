// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'package:pigeon/common/http/base_http.dart';
import 'package:pigeon/common/http/interceptors/interceptors.dart';

final ytHttp = YTHttp();

class YTHttp extends BaseHttp {
  YTHttp();

  @override
  void init() {
    // do something
    interceptors.addAll([
      YTBaseInterceptor(),
      if (!kReleaseMode) ...[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ],
    ]);
  }
}
