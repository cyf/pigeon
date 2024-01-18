import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/main_common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.create();
  await runMainApp();
}
