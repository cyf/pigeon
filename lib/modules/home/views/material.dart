import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/main.dart';

class MaterialHomePage extends StatefulWidget {
  const MaterialHomePage({super.key});

  @override
  State<MaterialHomePage> createState() => _MaterialHomePageState();
}

class _MaterialHomePageState extends State<MaterialHomePage> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? value) {
        if (kDebugMode) {
          log('A new getInitialMessage event was published!');
        }
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        log('A new onMessageOpenedApp event was published!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('app'),
      ),
    );
  }
}
