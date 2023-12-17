import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/api/config_api.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/gen/assets.gen.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:homing_pigeon/theme/theme.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final accountFocusNode = FocusNode();
  bool _isAccountFocus = false;

  final easyLoading = EasyLoading.init();

  bool _showPassword = false;
  bool _isAuthenticated = false;
  bool _isShowLoginDialog = false;

  @override
  void initState() {
    super.initState();
    accountFocusNode.addListener(() {
      setState(() {
        _isAccountFocus = accountFocusNode.hasFocus;
      });
    });

    _loadConfigs();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    onPressed: _onPressed,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(
                        !_isAuthenticated
                            ? primaryBackgroundColor
                            : primaryGrayColor,
                      ),
                    ),
                    icon: !_isAuthenticated
                        ? const Icon(
                            Icons.login,
                            color: primaryColor,
                            size: 20,
                          )
                        : CircleAvatar(
                            backgroundColor: primaryGrayColor,
                            child: Assets.logoRound.image(
                              width: 30,
                              height: 30,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onPressed() {
    if (_isShowLoginDialog) return;
    setState(() => _isShowLoginDialog = true);
    showLoginBottomSheet();
  }

  void showLoginBottomSheet() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;

    showModalBottomSheet<void>(
      context: AppNavigator.key.currentContext!,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext ctx1, StateSetter setInnerState) {
          return KeyboardDismisser(
            child: ModalBottomSheet(
              constraints: BoxConstraints(maxHeight: height - top - bottom),
              callback: _login,
              buttonText: '登录',
              items: [
                Row(
                  children: [
                    const Text(
                      '请填写登录信息',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        .nestedPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        )
                        .nestedExpanded(),
                    IconButton.outlined(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(5),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(secondaryGrayColor),
                        minimumSize:
                            MaterialStateProperty.all(const Size(24, 24)),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        setInnerState(() => _isShowLoginDialog = false);
                        NavigatorUtil.pop();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: borderColor,
                        size: 14,
                      ),
                    ).nestedPadding(padding: const EdgeInsets.only(right: 10)),
                  ],
                )
                    .nestedPadding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    )
                    .nestedDecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: primaryGrayColor,
                          ),
                        ),
                      ),
                    )
                    .nestedDecoratedBox(
                      decoration: const BoxDecoration(color: Colors.white),
                    )
                    .nestedSizedBox(width: width)
                    .nestedConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 64),
                    ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BaseFormItem(
                        title: '账号',
                        showTip: false,
                        padding: EdgeInsets.zero,
                        child: TextFormField(
                          focusNode: accountFocusNode,
                          controller: _accountController,
                          cursorColor: primaryColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          onChanged: (value) {
                            setInnerState(() {});
                          },
                          decoration: InputDecoration(
                            suffixIcon: (_isAccountFocus &&
                                    _accountController.text.isNotEmpty)
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: primaryGrayColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      splashRadius: 2,
                                      onPressed: () {
                                        // Clear everything in the text field
                                        _accountController.clear();
                                        // Call setState to update the UI
                                        setInnerState(() {});
                                      },
                                      iconSize: 16,
                                      icon: const Icon(
                                        Icons.clear,
                                        color: placeholderTextColor,
                                      ),
                                    ),
                                  )
                                : null,
                            suffixIconConstraints: const BoxConstraints(
                              maxWidth: 30,
                              maxHeight: 30,
                            ),
                            hintText: '请输入账号',
                            contentPadding: const EdgeInsets.all(8),
                            fillColor: secondaryGrayColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (StringUtil.isBlank(value)) {
                              return '请输入账号';
                            }
                            return null;
                          },
                        ).nestedPadding(
                          padding: const EdgeInsets.only(top: 8),
                        ),
                      ),
                      BaseFormItem(
                        title: '密码',
                        showTip: false,
                        child: TextFormField(
                          controller: _passwordController,
                          cursorColor: primaryColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          obscureText: !_showPassword,
                          onChanged: (value) {
                            setInnerState(() {});
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setInnerState(
                                  () => _showPassword = !_showPassword,
                                );
                              },
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: borderColor,
                                size: 18,
                              ),
                            ),
                            hintText: '请输入密码',
                            contentPadding: const EdgeInsets.all(8),
                            fillColor: secondaryGrayColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (StringUtil.isBlank(value)) {
                              return '请输入密码';
                            }
                            return null;
                          },
                        ).nestedPadding(
                          padding: const EdgeInsets.only(top: 8),
                        ),
                      ),
                    ],
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {}
  }

  void _loadConfigs() {
    ConfigApi.getConfigList().then<void>((configs) {
      BlocProvider.of<AppCubit>(context).addConfigs(configs);
    }).onError<RequestedException>(printErrorStackLog);
  }
}
