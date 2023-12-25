import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:synchronized/synchronized.dart';

class LogUtil {
  LogUtil._();
  static LogUtil? _singleton;
  static late Directory _tempDir;
  static Logger? _logger;
  static late String _logPath;
  static final Lock _lock = Lock();

  static Future<LogUtil?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          final singleton = LogUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  Future<void> _init() async {
    _tempDir = await getTemporaryDirectory();
    _logPath = '${_tempDir.path}/logs/log-${DateFormat('yyyy-MM-dd').format(DateTime.now())}.txt';

    LogPrinter? logPrinter;
    if (!kReleaseMode) {
      logPrinter = PrettyPrinter();
    }

    LogOutput? logOutput;
    if (kReleaseMode) {
      final file = File(_logPath);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      logOutput = FileOutput(file: file);
    }

    _logger = Logger(
      level: kReleaseMode ? Level.error : Level.trace,
      printer: logPrinter,
      output: logOutput,
      filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
    );
  }

  static void printDebugLog(Object? object) {
    final line = object?.toString();
    _logger?.d(line);
  }

  static void printWarningLog(Object? object) {
    final line = object?.toString();
    _logger?.w(line);
  }

  static void printErrorLog(
    dynamic error, {
    DateTime? time,
    StackTrace? stackTrace,
  }) {
    if (Constants.sentryEnabled && kReleaseMode) {
      Sentry.captureException(error, stackTrace: stackTrace);
    }
    _logger?.e(null, error: error, stackTrace: stackTrace);
  }

  static FutureOr<bool> printErrorStackLog(
    dynamic error,
    StackTrace? stackTrace,
  ) async {
    if (Constants.sentryEnabled && kReleaseMode) {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
    _logger?.e(null, error: error, stackTrace: stackTrace);

    return true;
  }

  /// get Temp Dir.
  static Directory? getTempDir() {
    return _tempDir;
  }

  /// get log path.
  static String getLogPath() {
    return _logPath;
  }

  /// get Logger.
  static Logger? getLogger() {
    return _logger;
  }
}
