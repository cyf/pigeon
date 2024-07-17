import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pigeon/app/config.dart';
import 'package:pigeon/app/manager.dart';
import 'package:pigeon/app/navigator.dart';
import 'package:pigeon/common/api/auth_api.dart';
import 'package:pigeon/common/api/carousel_api.dart';
import 'package:pigeon/common/constants/keys.dart';
import 'package:pigeon/common/extensions/extensions.dart';
import 'package:pigeon/common/http/utils/handle_errors.dart';
import 'package:pigeon/common/models/models.dart';
import 'package:pigeon/common/utils/color_util.dart';
import 'package:pigeon/common/utils/dialog_util.dart';
import 'package:pigeon/common/utils/navigator_util.dart';
import 'package:pigeon/common/utils/sp_util.dart';
import 'package:pigeon/common/utils/string_util.dart';
import 'package:pigeon/common/widgets/header.dart';
import 'package:pigeon/common/widgets/widgets.dart';
import 'package:pigeon/gen/assets.gen.dart';
import 'package:pigeon/i18n/i18n.dart';
import 'package:pigeon/modules/app/app.dart';
import 'package:pigeon/modules/detail/detail.dart';
import 'package:pigeon/modules/home/home.dart';
import 'package:pigeon/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const double carouselHeight = 250;

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final _loginFormKey = GlobalKey<FormBuilderState>();
  final _signupFormKey = GlobalKey<FormBuilderState>();
  final ScrollController _scrollController = ScrollController();
  bool isSliverAppBarExpanded = false;

  final accountFocusNode = FocusNode();
  final nicknameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final repeatPasswordFocusNode = FocusNode();

  List<CarouselModel> _carousels = [];
  bool _loading = false;
  String? _error;

  bool _isRegistered = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      DialogUtil.showLicenseDialog();
    });

    _scrollController.addListener(() {
      setState(() {
        isSliverAppBarExpanded = _scrollController.hasClients &&
            _scrollController.offset > carouselHeight - kToolbarHeight;
      });
    });

    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildScaffoldBody(),
      floatingActionButton: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return IconButton.filled(
            onPressed: state.user == null
                ? showLoginBottomSheet
                : showLogoutBottomSheet,
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              backgroundColor: WidgetStateProperty.all(
                state.user == null ? primaryBackgroundColor : primaryGrayColor,
              ),
            ),
            icon: state.user == null
                ? const Icon(
                    Icons.login,
                    color: primaryColor,
                    size: 20,
                  )
                : CircleAvatar(
                    backgroundColor: primaryGrayColor,
                    child: StringUtil.isNotBlank(state.user?.avatar)
                        ? Image.network(
                            StringUtil.getValue(state.user?.avatar),
                            width: 30,
                            height: 30,
                          )
                        : Assets.logoDark.image(
                            width: 30,
                            height: 30,
                          ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildScaffoldBody() {
    final t = Translations.of(context);
    final configs = BlocProvider.of<AppCubit>(context).state.configs;
    final roadmapConfig =
        configs?.firstWhereOrNull((config) => config.key == 'roadmap');
    final bottom = MediaQuery.paddingOf(context).bottom;
    final version = AppManager.instance.version;
    final buildNumber = AppManager.instance.buildNumber;
    final flavorName = AppConfig.shared.flavor.name;
    final showRoadmap =
        StringUtil.getValue(roadmapConfig?.value, defaultVal: 'disabled') ==
            'enabled';
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Add the app bar to the CustomScrollView.
        _buildSliverAppBar(),
        Section(
          title: t.pages.home.primary.title,
          items: [
            SectionItem(
              title: t.pages.home.primary.rating.title,
              tips: t.pages.home.primary.rating.description,
              onTap: () => NavigatorUtil.push(const MovieView()),
            ),
            if (AppConfig.shared.isExternal)
              SectionItem(
                title: t.pages.home.primary.live.title,
                tips: t.pages.home.primary.live.description,
                onTap: () => NavigatorUtil.push(const LiveView()),
              ),
            SectionItem(
              title: t.pages.home.primary.settings.title,
              onTap: () => NavigatorUtil.push(const LiveView()),
              showBorder: false,
            ),
          ],
        ),
        Section(
          title: t.pages.home.other.title,
          items: [
            SectionItem(
              title: t.pages.home.other.notifications.title,
              tips: t.pages.home.other.notifications.title,
              onTap: () => NavigatorUtil.push(const SocialView()),
            ),
            SectionItem(
              title: t.pages.home.other.store.title,
              tips: t.pages.home.other.store.title,
              tipsColor: errorTextColor,
              showBack: false,
              onTap: showShopModalBottomSheet,
            ),
            SectionItem(
              title: t.pages.home.other.emoji.title,
              tips: t.pages.home.other.emoji.description,
              onTap: () => NavigatorUtil.push(const EmojiView()),
            ),
            SectionItem(
              title: t.pages.home.other.feedback.title,
              tips: t.pages.home.other.feedback.description,
              onTap: () => NavigatorUtil.push(const FeedbackView()),
              showBorder: showRoadmap,
            ),
            if (showRoadmap)
              SectionItem(
                title: t.pages.home.other.roadmap.title,
                tips: t.pages.home.other.roadmap.description,
                onTap: () => NavigatorUtil.push(const RoadmapView()),
                showBorder: false,
              ),
          ],
        ),
        if (StringUtil.isNotBlank(version))
          SliverList.list(
            children: [
              Text(
                '${t.pages.home.version}: $version+$buildNumber($flavorName)',
                style: const TextStyle(fontSize: 12, color: secondaryTextColor),
                textAlign: TextAlign.center,
              ).nestedPadding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 20,
                ),
              ),
            ],
          ),
      ],
    ).nestedPadding(padding: EdgeInsets.only(bottom: bottom));
  }

  Widget _buildSliverAppBar() {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusBarHeight = MediaQuery.paddingOf(context).top;
    Widget? flexibleSpace;
    double? expandedHeight = carouselHeight;
    if (!_loading) {
      if (StringUtil.isNotBlank(_error)) {
        // 请求失败，显示错误
        flexibleSpace = FlexibleSpaceBar(
          // centerTitle: true,
          collapseMode: CollapseMode.pin,
          background: Text(
            _error!,
            style: const TextStyle(color: errorTextColor, fontSize: 14),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          )
              .nestedCenter()
              .nestedSizedBox(height: expandedHeight)
              .nestedPadding(padding: EdgeInsets.only(top: statusBarHeight)),
        );
      } else {
        // 请求成功，显示数据
        if (_carousels.isNotEmpty) {
          flexibleSpace = FlexibleSpaceBar(
            // centerTitle: true,
            collapseMode: CollapseMode.pin,
            background: CarouselSlider.builder(
              itemCount: _carousels.length,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) =>
                  _buildCarousel(_carousels[itemIndex]),
              options: CarouselOptions(
                autoPlay: true,
                height: carouselHeight + statusBarHeight,
                viewportFraction: 1,
                // enableInfiniteScroll: false,
              ),
            ),
          );
        } else {
          expandedHeight = null;
        }
      }
    } else {
      flexibleSpace = FlexibleSpaceBar(
        // centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: const CircularProgressIndicator(
          color: primaryColor,
        )
            .nestedSizedBox(width: 30, height: 30)
            .nestedCenter()
            .nestedPadding(padding: EdgeInsets.only(top: statusBarHeight)),
      );
    }

    return SliverAppBar(
      pinned: true,
      stretch: true,
      // backgroundColor: Colors.white,
      expandedHeight: expandedHeight,
      centerTitle: true,
      title: expandedHeight == null || isSliverAppBarExpanded
          ? Text(t.appName)
          : null,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      // actions: isSliverAppBarExpanded
      //     ? [
      //         IconButton(
      //           onPressed: () => {},
      //           iconSize: 20,
      //           color: primaryTextColor,
      //           icon: const Icon(Icons.account_circle_outlined),
      //         ),
      //       ]
      //     : [],
      flexibleSpace: flexibleSpace,
    );
  }

  Widget _buildCarousel(CarouselModel carousel) {
    final statusBarHeight = MediaQuery.paddingOf(context).top;
    final child = CachedNetworkImage(
      imageUrl: carousel.image,
      imageBuilder: (context, imageProvider) => Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(
        color: primaryColor,
      )
          .nestedSizedBox(width: 30, height: 30)
          .nestedCenter()
          .nestedPadding(padding: EdgeInsets.only(top: statusBarHeight)),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: errorTextColor,
      ),
    );

    if (StringUtil.isBlank(carousel.text)) {
      return child;
    }

    return Stack(
      children: [
        child,
        Positioned(
          left: 0,
          right: 10,
          bottom: 10,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              minimumSize: WidgetStateProperty.all(Size.zero),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight,
            ),
            onPressed: () async {
              if (StringUtil.isNotBlank(carousel.href)) {
                final uri = Uri.tryParse(carousel.href!);
                if (uri != null) {
                  await launchUrl(uri);
                }
              }
            },
            child: Text(
              carousel.text!,
              style: TextStyle(
                color: StringUtil.isNotBlank(carousel.color)
                    ? ColorUtil.stringToColor(carousel.color!, primaryTextColor)
                    : primaryTextColor,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  // 登录接口
  void _login() {
    final t = Translations.of(context);
    if (_loginFormKey.currentState!.validate()) {
      final fields = _loginFormKey.currentState!.instantValue;
      final account = fields['account'] as String;
      final password = fields['password'] as String;

      EasyLoading.show();
      AuthApi.login(account: account, password: password).then((value) {
        if (value != null) {
          NavigatorUtil.pop();
          EasyLoading.showSuccess(t.common.success);
          SpUtil.putString(
            Keys.tokenKey,
            StringUtil.getValue(value.accessToken),
          );
          SpUtil.putString(
            Keys.userIdKey,
            StringUtil.getValue(value.user?.id),
          );
          initJPush();
          initFirebase();
          BlocProvider.of<AppCubit>(context).addUser(value.user);
          return;
        }
        EasyLoading.showError(t.common.failure);
      }).onError<Exception>((error, stackTrace) {
        ErrorHandler.handle(
          error,
          stackTrace: stackTrace,
          postProcessor: (_, msg) {
            EasyLoading.showError(msg ?? t.common.failure);
          },
        );
      });
    }
  }

  // 注册接口
  void _register() {
    final t = Translations.of(context);
    if (_signupFormKey.currentState!.validate()) {
      final fields = _signupFormKey.currentState!.instantValue;
      final account = fields['account'] as String;
      final nickname = fields['nickname'] as String?;
      final email = fields['email'] as String;
      final password = fields['password'] as String;

      EasyLoading.show();
      AuthApi.register(
        username: account,
        password: password,
        email: email,
        nickname: nickname,
      ).then((value) {
        if (value != null) {
          NavigatorUtil.pop();
          EasyLoading.showSuccess(t.common.success);
          SpUtil.putString(
            Keys.tokenKey,
            StringUtil.getValue(value.accessToken),
          );
          SpUtil.putString(
            Keys.userIdKey,
            StringUtil.getValue(value.user?.id),
          );
          initJPush();
          initFirebase();
          BlocProvider.of<AppCubit>(context).addUser(value.user);
          return;
        }
        EasyLoading.showError(t.common.failure);
      }).onError<Exception>((error, stackTrace) {
        ErrorHandler.handle(
          error,
          stackTrace: stackTrace,
          postProcessor: (_, msg) {
            EasyLoading.showError(msg ?? t.common.failure);
          },
        );
      });
    }
  }

  // 退出接口
  void _logout() {
    NavigatorUtil.pop();
    BlocProvider.of<AppCubit>(context).addUser(null);
    SpUtil.remove(Keys.tokenKey);
    SpUtil.remove(Keys.userIdKey);
  }

  // 加载数据
  void _load() {
    final context = AppNavigator.key.currentContext!;
    final t = Translations.of(context);
    setState(() => _loading = true);
    CarouselApi.getCarouselList().then((carousels) {
      setState(() {
        _loading = false;
        _carousels = carousels;
      });
    }).onError<Exception>((error, stackTrace) {
      ErrorHandler.handle(
        error,
        stackTrace: stackTrace,
        postProcessor: (_, msg) {
          setState(() {
            _loading = false;
            _error = msg ?? t.common.failure;
          });
        },
      );
    });
  }

  void showShopModalBottomSheet() {
    final t = Translations.of(context);
    final configs = BlocProvider.of<AppCubit>(context).state.configs;
    final tbConfig =
        configs?.firstWhereOrNull((config) => config.key == 'taobao');

    const crossAxisAlignment = CrossAxisAlignment.center;
    const padding = EdgeInsets.zero;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) => ModalBottomSheet(
        buttonText: t.buttons.cancel,
        callback: NavigatorUtil.pop,
        header: HpHeader(
          title: t.bottomSheets.store.title,
          hideCancel: true,
        ),
        items: [
          if (StringUtil.isNotBlank(tbConfig?.value))
            SectionItem(
              title: t.bottomSheets.store.code.title,
              tips: t.bottomSheets.store.code.description,
              showBack: false,
              contentPadding: padding,
              innerPadding: padding,
              crossAxisAlignment: crossAxisAlignment,
              onTap: () => FlutterClipboard.copy(tbConfig!.value!).then(
                (value) {
                  EasyLoading.showSuccess(t.common.copied);
                  NavigatorUtil.pop();
                },
              ),
            ),
          SectionItem(
            title: t.bottomSheets.store.link.title,
            tips: t.bottomSheets.store.link.description,
            tipsColor: errorTextColor,
            showBack: false,
            showBorder: false,
            contentPadding: padding,
            innerPadding: padding,
            crossAxisAlignment: crossAxisAlignment,
            onTap: () async {
              NavigatorUtil.pop();
              final uri = Uri.parse('https://chenyifaer.taobao.com');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
          ),
        ],
      ),
    );
  }

  // 登录/注册弹窗
  void showLoginBottomSheet() {
    final t = Translations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    final passwordNotifier = ValueNotifier<bool>(false);
    final repeatPasswordNotifier = ValueNotifier<bool>(false);

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final buttonText = !_isRegistered ? t.buttons.login : t.buttons.signup;
        return StatefulBuilder(
          builder: (BuildContext ctx1, StateSetter setInnerState) {
            return KeyboardDismisser(
              child: ModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: height - top - buttonHeight - bottom,
                ),
                callback: !_isRegistered ? _login : _register,
                buttonText: buttonText,
                header: Row(
                  children: [
                    Text(
                      !_isRegistered
                          ? t.bottomSheets.login.header
                          : t.bottomSheets.signup.header,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : primaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                        .nestedPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        )
                        .nestedExpanded(),
                    IconButton.outlined(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.all(5),
                        ),
                        side: WidgetStateProperty.all(BorderSide.none),
                        backgroundColor: WidgetStateProperty.all(
                          isDark ? borderColor : secondaryGrayColor,
                        ),
                        elevation: WidgetStateProperty.all(0),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: NavigatorUtil.pop,
                      icon: Icon(
                        Icons.clear,
                        color: isDark ? secondaryTextColor : borderColor,
                        size: 14,
                      ),
                    ).nestedPadding(
                      padding: const EdgeInsets.only(right: 10),
                    ),
                  ],
                )
                    .nestedPadding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    )
                    .nestedDecoratedBox(
                      decoration: BoxDecoration(
                        color: isDark ? primaryTextColor : Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color:
                                isDark ? secondaryTextColor : primaryGrayColor,
                          ),
                        ),
                      ),
                    )
                    .nestedSizedBox(width: width)
                    .nestedConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 64),
                    ),
                items: [
                  FormBuilder(
                    key: !_isRegistered ? _loginFormKey : _signupFormKey,
                    child: Column(
                      children: [
                        BaseFormItem(
                          title: t.bottomSheets.login.form.account.title,
                          showTip: false,
                          padding: EdgeInsets.zero,
                          child: FormBuilderField<String>(
                            focusNode: accountFocusNode,
                            builder: (FormFieldState<String> field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    initialValue: field.value,
                                    focusNode: accountFocusNode,
                                    cursorColor: primaryColor,
                                    cursorErrorColor: errorTextColor,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    autocorrect: false,
                                    style: const TextStyle(
                                      color: primaryTextColor,
                                    ),
                                    onChanged: (value) {
                                      field
                                        ..didChange(value)
                                        ..validate();
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        10,
                                        10,
                                        5,
                                        10,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                          color: borderColor,
                                        ),
                                        gapPadding: 0,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                          color: borderColor,
                                        ),
                                        gapPadding: 0,
                                      ),
                                      hintText: t.bottomSheets.login.form
                                          .account.hintText,
                                      helperText: _isRegistered
                                          ? t.bottomSheets.signup.form.account
                                              .helperText
                                          : null,
                                      helperMaxLines: 2,
                                      helperStyle: const TextStyle(
                                        color: secondaryTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      errorText: field.errorText,
                                      errorStyle: const TextStyle(
                                        fontSize: 12,
                                        color: errorTextColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                          color: primaryColor,
                                        ),
                                        gapPadding: 0,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                          color: errorTextColor,
                                        ),
                                        gapPadding: 0,
                                      ),
                                      // fillColor: epPrimaryGrayColor,
                                      // filled: true,
                                    ),
                                  ),
                                ],
                              );
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText:
                                    t.bottomSheets.login.form.account.errorText,
                              ),
                              FormBuilderValidators.match(
                                RegExp('[a-zA-Z][a-zA-Z0-9_]{7,}', multiLine: true),
                                errorText: _isRegistered
                                    ? t.bottomSheets.signup.form.account
                                        .errorText2
                                    : t.bottomSheets.login.form.account
                                        .errorText2,
                              ),
                              // TODO(kjxbyz): 与数据库联动，账号唯一
                            ]),
                            name: 'account',
                          ).nestedPadding(
                            padding: const EdgeInsets.only(top: 8),
                          ),
                        ),
                        if (_isRegistered) ...[
                          BaseFormItem(
                            title: t.bottomSheets.signup.form.nickname.title,
                            required: false,
                            showTip: false,
                            child: FormBuilderField<String>(
                              focusNode: nicknameFocusNode,
                              builder: (FormFieldState<String> field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      initialValue: field.value,
                                      focusNode: nicknameFocusNode,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      cursorColor: primaryColor,
                                      cursorErrorColor: errorTextColor,
                                      autocorrect: false,
                                      // inputFormatters: [
                                      //   LengthLimitingTextInputFormatter(20),
                                      // ],
                                      style: const TextStyle(
                                        color: primaryTextColor,
                                      ),
                                      onChanged: (value) {
                                        field
                                          ..didChange(value)
                                          ..validate();
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                          10,
                                          10,
                                          5,
                                          10,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: borderColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: borderColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        hintText: t.bottomSheets.signup.form
                                            .nickname.hintText,
                                        helperText: _isRegistered
                                            ? t.bottomSheets.signup.form
                                                .nickname.helperText
                                            : null,
                                        helperMaxLines: 2,
                                        helperStyle: const TextStyle(
                                          color: secondaryTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        errorText: field.errorText,
                                        errorStyle: const TextStyle(
                                          fontSize: 12,
                                          color: errorTextColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        ),
                                        // fillColor: epPrimaryGrayColor,
                                        // filled: true,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.maxLength(
                                  20,
                                  errorText: t.bottomSheets.signup.form.nickname
                                      .errorText,
                                ),
                              ]),
                              name: 'nickname',
                            ).nestedPadding(
                              padding: const EdgeInsets.only(top: 8),
                            ),
                          ),
                          BaseFormItem(
                            title: t.bottomSheets.signup.form.email.title,
                            showTip: false,
                            child: FormBuilderField<String>(
                              focusNode: emailFocusNode,
                              builder: (FormFieldState<String> field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      initialValue: field.value,
                                      focusNode: emailFocusNode,
                                      cursorColor: primaryColor,
                                      cursorErrorColor: errorTextColor,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: false,
                                      style: const TextStyle(
                                        color: primaryTextColor,
                                      ),
                                      onChanged: (value) {
                                        field
                                          ..didChange(value)
                                          ..validate();
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                          10,
                                          10,
                                          5,
                                          10,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: borderColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: borderColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        hintText: t.bottomSheets.signup.form
                                            .email.hintText,
                                        helperMaxLines: 2,
                                        helperStyle: const TextStyle(
                                          color: secondaryTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        errorText: field.errorText,
                                        errorStyle: const TextStyle(
                                          fontSize: 12,
                                          color: errorTextColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        ),
                                        // fillColor: epPrimaryGrayColor,
                                        // filled: true,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: t
                                      .bottomSheets.signup.form.email.errorText,
                                ),
                                FormBuilderValidators.email(
                                  errorText: t.bottomSheets.signup.form.email
                                      .errorText2,
                                ),
                                // TODO(kjxbyz): 与数据库联动，邮箱唯一
                              ]),
                              name: 'email',
                            ).nestedPadding(
                              padding: const EdgeInsets.only(top: 8),
                            ),
                          ),
                        ],
                        BaseFormItem(
                          title: t.bottomSheets.login.form.password.title,
                          showTip: false,
                          child: FormBuilderField<String>(
                            focusNode: passwordFocusNode,
                            builder: (FormFieldState<String> field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: passwordNotifier,
                                    builder: (
                                      BuildContext context,
                                      bool passwordVisible,
                                      Widget? child,
                                    ) =>
                                        TextFormField(
                                      initialValue: field.value,
                                      focusNode: passwordFocusNode,
                                      obscureText: !passwordVisible,
                                      cursorColor: primaryColor,
                                      cursorErrorColor: errorTextColor,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: false,
                                      style: const TextStyle(
                                        color: primaryTextColor,
                                      ),
                                      onChanged: (value) {
                                        field
                                          ..didChange(value)
                                          ..validate();
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                          10,
                                          10,
                                          5,
                                          10,
                                        ),
                                        suffixIcon: IconButton(
                                          splashRadius: 2,
                                          onPressed: () {
                                            passwordNotifier.value =
                                                !passwordNotifier.value;
                                          },
                                          iconSize: 16,
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: const Color.fromARGB(
                                              65,
                                              0,
                                              0,
                                              0,
                                            ),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: borderColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: borderColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        hintText: t.bottomSheets.login.form
                                            .password.hintText,
                                        helperText: _isRegistered
                                            ? t.bottomSheets.signup.form
                                                .password.helperText
                                            : null,
                                        helperMaxLines: 2,
                                        helperStyle: const TextStyle(
                                          color: secondaryTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        errorText: field.errorText,
                                        errorStyle: const TextStyle(
                                          fontSize: 12,
                                          color: errorTextColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          gapPadding: 0,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        ),
                                        // fillColor: epPrimaryGrayColor,
                                        // filled: true,
                                      ),
                                    ),
                                  ),
                                  if (_isRegistered)
                                    BaseFormItem(
                                      title: t.bottomSheets.signup.form
                                          .repeatPassword.title,
                                      showTip: false,
                                      child: FormBuilderField<String>(
                                        focusNode: repeatPasswordFocusNode,
                                        builder: (
                                          FormFieldState<String> repeatPwdField,
                                        ) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ValueListenableBuilder(
                                                valueListenable:
                                                    repeatPasswordNotifier,
                                                builder: (
                                                  BuildContext context,
                                                  bool repeatPasswordVisible,
                                                  Widget? child,
                                                ) =>
                                                    TextFormField(
                                                  initialValue:
                                                      repeatPwdField.value,
                                                  obscureText:
                                                      !repeatPasswordVisible,
                                                  focusNode:
                                                      repeatPasswordFocusNode,
                                                  cursorColor: primaryColor,
                                                  cursorErrorColor:
                                                      errorTextColor,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  autocorrect: false,
                                                  style: const TextStyle(
                                                    color: primaryTextColor,
                                                  ),
                                                  onChanged: (value) {
                                                    repeatPwdField
                                                      ..didChange(value)
                                                      ..validate();
                                                  },
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                      10,
                                                      10,
                                                      5,
                                                      10,
                                                    ),
                                                    suffixIcon: IconButton(
                                                      splashRadius: 2,
                                                      onPressed: () {
                                                        repeatPasswordNotifier
                                                                .value =
                                                            !repeatPasswordNotifier
                                                                .value;
                                                      },
                                                      iconSize: 16,
                                                      icon: Icon(
                                                        repeatPasswordVisible
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        color: const Color
                                                            .fromARGB(
                                                          65,
                                                          0,
                                                          0,
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: borderColor,
                                                      ),
                                                      gapPadding: 0,
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: borderColor,
                                                      ),
                                                      gapPadding: 0,
                                                    ),
                                                    hintText: t
                                                        .bottomSheets
                                                        .signup
                                                        .form
                                                        .repeatPassword
                                                        .hintText,
                                                    helperMaxLines: 2,
                                                    errorText: repeatPwdField
                                                        .errorText,
                                                    errorStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: errorTextColor,
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: primaryColor,
                                                      ),
                                                      gapPadding: 0,
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: errorTextColor,
                                                      ),
                                                      // borderSide: BorderSide.none,
                                                      gapPadding: 0,
                                                    ),
                                                    // fillColor: epPrimaryGrayColor,
                                                    // filled: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                            errorText: t.bottomSheets.signup
                                                .form.repeatPassword.errorText,
                                          ),
                                          if (StringUtil.isNotBlank(
                                            field.value,
                                          ))
                                            FormBuilderValidators.equal(
                                              field.value!,
                                              errorText: t
                                                  .bottomSheets
                                                  .signup
                                                  .form
                                                  .repeatPassword
                                                  .errorText2,
                                            ),
                                        ]),
                                        name: 'repeatPassword',
                                      ).nestedPadding(
                                        padding: const EdgeInsets.only(top: 8),
                                      ),
                                    ),
                                ],
                              );
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: t
                                    .bottomSheets.login.form.password.errorText,
                              ),
                              FormBuilderValidators.minLength(
                                8,
                                errorText: t.bottomSheets.login.form.password
                                    .errorText2,
                              ),
                            ]),
                            name: 'password',
                          ).nestedPadding(
                            padding: const EdgeInsets.only(top: 8),
                          ),
                        ),
                        BaseFormItem(
                          child: FormBuilderField<bool>(
                            name: t.bottomSheets.login.form.privacy.title,
                            initialValue: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (!(value ?? false)) {
                                return t
                                    .bottomSheets.login.form.privacy.errorText;
                              }
                              return null;
                            },
                            builder: (FormFieldState<bool> field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: field.value ?? false,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        fillColor: WidgetStateProperty.all(
                                          isDark
                                              ? primaryTextColor
                                              : Colors.white,
                                        ),
                                        checkColor: primaryColor,
                                        side:
                                            WidgetStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                            color: borderColor,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          field
                                            ..didChange(value ?? false)
                                            ..validate();
                                          setInnerState(() => {});
                                        },
                                      ).nestedSizedBox(
                                        width: 20,
                                        height: 14,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: t.bottomSheets.login.form
                                                  .privacy.prefix,
                                            ),
                                            TextSpan(
                                              text: t.bottomSheets.login.form
                                                  .privacy.privacy,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  // https://www.chenyifaer.com/homing-pigeon/zh/legal/privacy/
                                                  final uri = Uri.parse(
                                                    'https://www.chenyifaer.com/homing-pigeon/zh/legal/privacy/',
                                                  );
                                                  if (await canLaunchUrl(
                                                    uri,
                                                  )) {
                                                    await launchUrl(uri);
                                                  }
                                                },
                                              style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: t.bottomSheets.login.form
                                                  .privacy.and,
                                            ),
                                            TextSpan(
                                              text: t.bottomSheets.login.form
                                                  .privacy.terms,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  // https://www.chenyifaer.com/homing-pigeon/zh/legal/terms-of-use/
                                                  final uri = Uri.parse(
                                                    'https://www.chenyifaer.com/homing-pigeon/zh/legal/terms-of-use/',
                                                  );
                                                  if (await canLaunchUrl(
                                                    uri,
                                                  )) {
                                                    await launchUrl(uri);
                                                  }
                                                },
                                              style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                          style: TextStyle(
                                            color: isDark
                                                ? secondaryGrayColor
                                                : primaryTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                          .nestedPadding(
                                            padding: const EdgeInsets.only(
                                              left: 6,
                                            ),
                                          )
                                          .nestedExpanded(),
                                    ],
                                  ),
                                  if (StringUtil.isNotBlank(field.errorText))
                                    Text(
                                      field.errorText!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: errorTextColor,
                                      ),
                                    ).nestedPadding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 8,
                                      ),
                                    ),
                                ],
                              );
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !_isRegistered
                              ? t.bottomSheets.signup.tips.prefix
                              : t.bottomSheets.login.tips.prefix,
                          style: TextStyle(
                            color: isDark
                                ? secondaryBorderColor
                                : secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: !_isRegistered
                              ? t.bottomSheets.signup.tips.suffix
                              : t.bottomSheets.login.tips.suffix,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              setInnerState(() {
                                // _formKey.currentState?.reset();
                                _isRegistered = !_isRegistered;
                              });
                            },
                          style: TextStyle(
                            color: isDark
                                ? secondaryBorderColor
                                : secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ).nestedCenter().nestedPadding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                      ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 退出弹窗
  void showLogoutBottomSheet() {
    final t = Translations.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext ctx1, StateSetter setInnerState) {
          return KeyboardDismisser(
            child: ModalBottomSheet(
              constraints: BoxConstraints(maxHeight: height - top - bottom),
              callback: _logout,
              buttonText: t.buttons.logout,
            ),
          );
        },
      ),
    );
  }
}
