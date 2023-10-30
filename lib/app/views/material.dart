import 'package:flutter/material.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/theme/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MaterialAppView extends StatelessWidget {
  const MaterialAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      home: const Scaffold(
        body: Center(child: Text('app'),),
      ),
    );
  }
}
