import 'dart:async';

import 'package:homing_pigeon/common/utils/log_util.dart';

void printDebugLog(Object? object) {
  LogUtil.printDebugLog(object);
}

void printWarningLog(Object? object) {
  LogUtil.printWarningLog(object);
}

void printErrorLog(
  dynamic error, {
  DateTime? time,
  StackTrace? stackTrace,
}) {
  LogUtil.printErrorLog(error, time: time, stackTrace: stackTrace);
}

FutureOr<bool> printErrorStackLog(dynamic error, StackTrace? stackTrace) async {
  return LogUtil.printErrorStackLog(error, stackTrace);
}
