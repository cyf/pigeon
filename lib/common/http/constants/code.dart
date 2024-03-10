import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/event/http_error_event.dart';
import 'package:homing_pigeon/common/http/widget/http_error_boundary.dart';

class Code {
  /// 网络错误
  static const networkError = '-1';

  static const networkUnAuthorized = '401';

  static const networkUnAccess = '403';

  static HpError? errorHandleFunction(
    String? code,
    String? message, {
    bool noTip = false,
  }) {
    if (noTip) {
      return HpError.from(code, message);
    }

    HttpErrorBoundary.handleErrorEvent(HttpErrorEvent(code, message));

    return HpError.from(code, message);
  }
}
