import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

const double offset = 20;

class _AppViewState extends State<AppView> {
  final easyLoading = EasyLoading.init();

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
      home: UpgradeAlert(
        navigatorKey: AppNavigator.key,
        child: const HomeView(),
      ),
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
}
