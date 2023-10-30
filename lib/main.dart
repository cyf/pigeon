import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/app/app.dart';
import 'package:homing_pigeon/constrants/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> collectLog(String line) async {
  log(line);
  await Sentry.captureMessage(line);
}

Future<void> reportErrorAndLog(FlutterErrorDetails details) async {
  log(details.exceptionAsString(), stackTrace: details.stack);
  await Sentry.captureException(details.exception, stackTrace: details.stack);
}

FlutterErrorDetails makeErrorDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final onError = FlutterError.onError;
  FlutterError.onError = (details) async {
    onError?.call(details);
    await reportErrorAndLog(details);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    reportErrorAndLog(makeErrorDetails(error, stackTrace));
    return true;
  };

  if (isMobile) {
    await Firebase.initializeApp();
  }

  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://c0846b730913410f9041993f54e641ec@o513893.ingest.sentry.io/4505132030296064'
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        ..tracesSampleRate = 1.0;
    },
  );

  runApp(const App());
}
