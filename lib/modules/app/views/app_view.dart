import 'package:flutter/material.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/theme.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.key,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeView(),
    );
  }
}
