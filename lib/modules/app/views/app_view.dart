import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/upload_util.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

const double offset = 20;

class _AppViewState extends State<AppView> {
  final easyLoading = EasyLoading.init();

  @override
  void initState() {
    super.initState();
    initPostPolicy();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.key,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      home: const HomeView(),
      builder: (BuildContext context, Widget? child) {
        final newChild = easyLoading(context, child);
        return MediaQuery(
          /// 设置文字大小不随系统设置改变
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: Scaffold(
            body: Stack(
              children: [
                newChild,
                Positioned(
                  right: offset,
                  bottom: bottom + offset * 2,
                  child: IconButton.filled(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    icon: const CircleAvatar(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void initPostPolicy() {
    UploadUtil.loadOssParams().then<void>((value) {
      if (value != null) {
        SpUtil.putString(Keys.postPolicyKey, json.encode(value.toJson()));
      }
    }).onError<RequestedException>(
      (error, stackTrace) => log(error.msg, stackTrace: stackTrace),
    );
  }
}
