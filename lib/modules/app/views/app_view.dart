import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jpush_flutter2/jpush_flutter2.dart';
import 'package:pigeon/app/config.dart';
import 'package:pigeon/app/manager.dart';
import 'package:pigeon/app/navigator.dart';
// import 'package:pigeon/common/api/auth_api.dart';
import 'package:pigeon/common/api/config_api.dart';
import 'package:pigeon/common/constants/constants.dart';
import 'package:pigeon/common/constants/keys.dart';
import 'package:pigeon/common/extensions/single.dart';
import 'package:pigeon/common/http/utils/handle_errors.dart';
import 'package:pigeon/common/utils/run_once.dart';
import 'package:pigeon/common/utils/sp_util.dart';
import 'package:pigeon/i18n/i18n.dart';
import 'package:pigeon/modules/app/app.dart';
import 'package:pigeon/modules/home/home.dart';
import 'package:pigeon/theme/colors.dart';
import 'package:pigeon/theme/theme.dart';
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

  final _memoizer = AsyncMemoizer<Widget>();
  Future<Widget>? _future;

  @override
  void initState() {
    super.initState();
    _loadConfigs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => MaterialApp(
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
        home: FutureBuilder<Widget>(
          future: _future ??= navigateToPage(),
          builder: (
            BuildContext context,
            AsyncSnapshot<Widget> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              final child = snapshot.data;
              return UpgradeAlert(child: child);
            } else {
              // 请求未结束，显示loading
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ).nestedColoredBox(color: Colors.white);
            }
          },
        ),
        builder: (BuildContext context, Widget? child) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          EasyLoading.instance.loadingStyle =
              isDark ? EasyLoadingStyle.light : EasyLoadingStyle.dark;
          final newChild = easyLoading(context, child);
          return MediaQuery(
            /// 设置文字大小不随系统设置改变
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: newChild,
          );
        },
      ),
    );
  }

  Future<Widget> navigateToPage() async {
    return _memoizer.runOnce(() async {
      try {
        // final res = await AuthApi.profile();

        // remove the splash screen
        FlutterNativeSplash.remove();

        if (AppConfig.shared.isInternal) {
          final licenseValue = SpUtil.getBool(Keys.licenseKey) ?? true;
          await JPushFlutter.setAuth(auth: licenseValue);
        }

        // if (res != null) {
          // BlocProvider.of<AppCubit>(context).addUser(res);

          AppView.runOnce(() {
            if (AppConfig.shared.isInternal &&
                !AppManager.instance.jPushInitialized) {
              initJPush();
            }

            if (AppConfig.shared.isExternal &&
                !AppManager.instance.firebaseInitialized) {
              initFirebase();
            }
          });
        // }
      } on Exception catch (error, stackTrace) {
        // remove the splash screen
        FlutterNativeSplash.remove();
        ErrorHandler.handle(error, stackTrace: stackTrace);
      }

      return const HomeView();
    });
  }

  void _loadConfigs() {
    ConfigApi.getConfigList().then<void>((configs) {
      BlocProvider.of<AppCubit>(context).addConfigs(configs);
    }).onError<Exception>(
      (error, stackTrace) => ErrorHandler.handle(error, stackTrace: stackTrace),
    );
  }
}
