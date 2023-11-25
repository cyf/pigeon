import 'package:homing_pigeon/common/exception/requested_error.dart';

/// common exception
class RequestedException implements Exception {
  const RequestedException(this.content);
  final dynamic content;

  String get msg {
    return toString();
  }

  @override
  String toString() {
    if (content == null) return 'RequestedException';
    if (content is HpError) {
      return (content as HpError).getMsg();
    }
    return '$content';
  }
}
