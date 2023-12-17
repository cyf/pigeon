import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/api/config_api.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (_) => AppCubit(),
      child: const AppView(),
    );
  }
}

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
    _loadConfigs();
  }

  @override
  Widget build(BuildContext context) {
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
          child: newChild,
        );
      },
    );
  }

  void _loadConfigs() {
    ConfigApi.getConfigList().then<void>((configs) {
      BlocProvider.of<AppCubit>(context).addConfigs(configs);
    }).onError<RequestedException>(printErrorStackLog);
  }
}
