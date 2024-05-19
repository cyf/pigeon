import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/api/auth_api.dart';
import 'package:homing_pigeon/common/api/config_api.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/http/utils/handle_errors.dart';
import 'package:homing_pigeon/common/utils/run_once.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/i18n/i18n.dart';
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

  static final runOnce = RunOnce();

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
      darkTheme: AppTheme.dark,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      navigatorObservers: [
        if (Constants.sentryEnabled) SentryNavigatorObserver(),
      ],
      home: UpgradeAlert(
        navigatorKey: AppNavigator.key,
        child: navigateToPage(context),
      ),
      builder: (BuildContext context, Widget? child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        EasyLoading.instance.loadingStyle =
            isDark ? EasyLoadingStyle.light : EasyLoadingStyle.dark;
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

  Widget navigateToPage(BuildContext context) {
    final user = BlocProvider.of<AppCubit>(context).state.user;
    final token = SpUtil.getString(Keys.tokenKey);

    AppView.runOnce(() {
      if (StringUtil.isNotBlank(token)) {
        /// 设置消息推送收集开关
        // if (Platform.isIOS ||
        //     (Platform.isAndroid && AppConfig.shared.isInternal)) {
        //   JPushFlutter.setAuth(auth: true);
        // }

        if (user == null) {
          AuthApi.profile().then((value) {
            if (value != null) {
              BlocProvider.of<AppCubit>(context).addUser(value);

              if (!AppManager.instance.jPushInitialized) {
                initJPush();
              }

              if (!AppManager.instance.firebaseInitialized) {
                initFirebase();
              }
            }
          }).onError<Exception>((error, stackTrace) {
            ErrorHandler.handle(error, stackTrace: stackTrace);
          });
        }
      }
    });

    return const HomeView();
  }

  void _loadConfigs() {
    ConfigApi.getConfigList().then<void>((configs) {
      BlocProvider.of<AppCubit>(context).addConfigs(configs);
    }).onError<Exception>(
      (error, stackTrace) => ErrorHandler.handle(error, stackTrace: stackTrace),
    );
  }
}
