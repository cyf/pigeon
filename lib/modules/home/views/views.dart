import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homing_pigeon/modules/home/views/ios.dart';
import 'package:homing_pigeon/modules/home/views/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return const IOSHomePage();
    return const MaterialHomePage();
  }
}
