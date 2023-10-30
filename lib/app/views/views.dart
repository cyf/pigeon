import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:homing_pigeon/app/views/ios.dart';
import 'package:homing_pigeon/app/views/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return const IOSAppView();
    return const MaterialAppView();
  }
}
