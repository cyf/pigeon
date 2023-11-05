import 'package:flutter/cupertino.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/home/home.dart';

class IOSAppView extends StatelessWidget {
  const IOSAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.key,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const IOSHomePage(),
    );
  }
}
