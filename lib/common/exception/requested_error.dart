/// common error
class HpError {
  const HpError({this.code, this.msg});

  const HpError.from(this.code, this.msg);

  final int? code;
  final String? msg;

  String getMsg() {
    return msg ?? 'Request Error';
  }

  @override
  String toString() {
    if (code == null && msg == null) return 'Request Error';
    return 'code: $code, msg: $msg';
  }
}
