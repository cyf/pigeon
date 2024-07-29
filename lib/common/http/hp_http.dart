// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'package:pigeon/common/http/base_http.dart';
import 'package:pigeon/common/http/interceptors/interceptors.dart';

final hpHttp = HpHttp();

class HpHttp extends BaseHttp {
  HpHttp();

  @override
  void init() {
    // do something
    interceptors.addAll([
      BaseInterceptor(),
      if (!kReleaseMode) ...[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ],
    ]);
  }
}
