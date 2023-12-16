import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

void printDebugLog(Object? object) {
  if (!kReleaseMode) {
    final line = object?.toString();
    logger.d(line);
  }
}

void printWarningLog(Object? object) {
  if (!kReleaseMode) {
    final line = object?.toString();
    logger.w(line);
  }
}

void printErrorLog(
  dynamic error, {
  DateTime? time,
  StackTrace? stackTrace,
}) {
  if (Constants.sentryEnabled && kReleaseMode) {
    Sentry.captureException(error, stackTrace: stackTrace);
  }
  if (!kReleaseMode) {
    logger.e(null, error: error, stackTrace: stackTrace);
  }
}

FutureOr<void> printErrorStackLog(dynamic error, StackTrace? stackTrace) async {
  if (Constants.sentryEnabled && kReleaseMode) {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
  if (!kReleaseMode) {
    logger.e(null, error: error, stackTrace: stackTrace);
  }
}
