import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/api/auth_api.dart';
import 'package:homing_pigeon/common/api/carousel_api.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/http/utils/handle_errors.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/color_util.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/widgets/header.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/gen/assets.gen.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const double carouselHeight = 250;

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);
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
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(
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
                        : Assets.logoRound.image(
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
    final configs = BlocProvider.of<AppCubit>(context).state.configs;
    final roadmapConfig =
        configs?.firstWhereOrNull((config) => config.key == 'roadmap');
    final bottom = MediaQuery.of(context).padding.bottom;
    final version = AppManager.instance.version;
    final showRoadmap =
        StringUtil.getValue(roadmapConfig?.value, defaultVal: 'disabled') ==
            'enabled';
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Add the app bar to the CustomScrollView.
        _buildSliverAppBar(),
        Section(
          title: '主要功能',
          items: [
            SectionItem(
              title: '电影打分系统',
              tips: '给看过的电影打个分吧~~',
              onTap: () => NavigatorUtil.push(const MovieView()),
            ),
            SectionItem(
              title: '直播预告',
              tips: '查看详情',
              onTap: () => NavigatorUtil.push(const LiveView()),
            ),
            SectionItem(
              title: '开播通知设置',
              onTap: () => NavigatorUtil.push(const LiveView()),
              showBorder: false,
            ),
          ],
        ),
        Section(
          title: '其他功能',
          items: [
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间等',
              onTap: () => NavigatorUtil.push(const SocialView()),
            ),
            SectionItem(
              title: '小德官方店: 喜瑞斯',
              tips: '寒潮啦! 来件卫衣吧~~',
              tipsColor: errorTextColor,
              showBack: false,
              onTap: showShopModalBottomSheet,
            ),
            SectionItem(
              title: '小德表情包🐱',
              tips: '欢迎投稿~~',
              onTap: () => NavigatorUtil.push(const EmojiView()),
            ),
            SectionItem(
              title: '意见/建议',
              tips: '无论您遇到任何问题、意见或建议, 均可反馈...',
              onTap: () => NavigatorUtil.push(const FeedbackView()),
              showBorder: showRoadmap,
            ),
            if (showRoadmap)
              SectionItem(
                title: '路线图',
                tips: '查看开发计划或进度😄',
                onTap: () => NavigatorUtil.push(const RoadmapView()),
                showBorder: false,
              ),
          ],
        ),
        if (StringUtil.isNotBlank(version))
          SliverList.list(
            children: [
              Text(
                '版本号: ${version!}(${AppConfig.shared.flavor.name})',
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusBarHeight = MediaQuery.of(context).padding.top;
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
      title: expandedHeight == null || isSliverAppBarExpanded
          ? Text(AppLocalizations.of(context).appName)
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
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final child = CachedNetworkImage(
      imageUrl: carousel.image,
      imageBuilder: (context, imageProvider) => Container(
        width: MediaQuery.of(context).size.width,
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
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              minimumSize: MaterialStateProperty.all(Size.zero),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
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

  void showLoginBottomSheet() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;

    final passwordNotifier = ValueNotifier<bool>(false);
    final repeatPasswordNotifier = ValueNotifier<bool>(false);

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (BuildContext ctx1, StateSetter setInnerState) {
            return KeyboardDismisser(
              child: ModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: height - top - buttonHeight - bottom,
                ),
                callback: !_isRegistered ? _login : _register,
                buttonText: !_isRegistered ? '登录' : '注册',
                header: Row(
                  children: [
                    Text(
                      '请填写${!_isRegistered ? '登录' : '注册'}信息',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : primaryTextColor,
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
                        side: MaterialStateProperty.all(BorderSide.none),
                        backgroundColor: MaterialStateProperty.all(
                          isDark ? borderColor : secondaryGrayColor,
                        ),
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(Size.zero),
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
                          title: '账号',
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
                                      hintText: '请输入账号',
                                      helperText: _isRegistered
                                          ? '只能包含英文, 数字或下划线, 且只能以字母开头, 至少8个字符'
                                          : null,
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
                                errorText: '请输入账号',
                              ),
                              FormBuilderValidators.match(
                                r'^[a-zA-Z][a-zA-Z0-9_]{7,}$',
                                errorText: _isRegistered
                                    ? '账号只能包含英文,数字或下划线, 且只能以字母开头, 至少8个字符'
                                    : '至少8个字符',
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
                            title: '昵称',
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
                                        hintText: '请输入昵称',
                                        helperText:
                                            _isRegistered ? '不能多于20个字符' : null,
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
                                  errorText: '昵称长度不能大于20',
                                ),
                              ]),
                              name: 'nickname',
                            ).nestedPadding(
                              padding: const EdgeInsets.only(top: 8),
                            ),
                          ),
                          BaseFormItem(
                            title: '邮箱',
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
                                        hintText: '请输入邮箱',
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
                                  errorText: '请输入邮箱',
                                ),
                                FormBuilderValidators.email(
                                  errorText: '邮箱格式错误',
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
                          title: '密码',
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
                                        hintText: '请输入密码',
                                        helperText:
                                            _isRegistered ? '不能少于8个字符' : null,
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
                                      title: '重复密码',
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
                                                    hintText: '请再次输入密码',
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
                                            errorText: '请再次输入密码',
                                          ),
                                          if (StringUtil.isNotBlank(
                                            field.value,
                                          ))
                                            FormBuilderValidators.equal(
                                              field.value!,
                                              errorText: '两次输入的密码不一样',
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
                                errorText: '请输入密码',
                              ),
                              FormBuilderValidators.minLength(
                                8,
                                errorText: '请至少输入8个字符',
                              ),
                            ]),
                            name: 'password',
                          ).nestedPadding(
                            padding: const EdgeInsets.only(top: 8),
                          ),
                        ),
                        BaseFormItem(
                          child: FormBuilderField<bool>(
                            name: 'privacy',
                            initialValue: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (!(value ?? false)) {
                                return '请同意隐私协议';
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
                                        fillColor: MaterialStateProperty.all(
                                          isDark ? primaryTextColor : Colors.white,
                                        ),
                                        checkColor: primaryColor,
                                        side:
                                            MaterialStateBorderSide.resolveWith(
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
                                            const TextSpan(
                                              text: '我已仔细阅读并同意',
                                            ),
                                            TextSpan(
                                              text: '隐私政策',
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
                                            const TextSpan(
                                              text: '以及',
                                            ),
                                            TextSpan(
                                              text: '条款和条件',
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
                          text: !_isRegistered ? '还没有账号, ' : '已有账号, ',
                          style: TextStyle(
                            color: isDark
                                ? secondaryBorderColor
                                : secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: !_isRegistered ? '去注册' : '去登录',
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

  void showLogoutBottomSheet() {
    final height = MediaQuery.of(context).size.height;
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;

    showModalBottomSheet<void>(
      context: AppNavigator.key.currentContext!,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext ctx1, StateSetter setInnerState) {
          return KeyboardDismisser(
            child: ModalBottomSheet(
              constraints: BoxConstraints(maxHeight: height - top - bottom),
              callback: _logout,
              buttonText: '退出',
            ),
          );
        },
      ),
    );
  }

  // 登录接口
  void _login() {
    if (_loginFormKey.currentState!.validate()) {
      final fields = _loginFormKey.currentState!.instantValue;
      final account = fields['account'] as String;
      final password = fields['password'] as String;

      EasyLoading.show();
      AuthApi.login(account: account, password: password).then((value) {
        if (value != null) {
          NavigatorUtil.pop();
          EasyLoading.showSuccess('Success');
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
        EasyLoading.showError('Failure');
      }).onError<Exception>((error, stackTrace) {
        ErrorHandler.handle(
          error,
          stackTrace: stackTrace,
          postProcessor: (_, msg) {
            EasyLoading.showError(msg ?? 'Failure');
          },
        );
      });
    }
  }

  // 注册接口
  void _register() {
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
          EasyLoading.showSuccess('Success');
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
        EasyLoading.showError('Failure');
      }).onError<Exception>((error, stackTrace) {
        ErrorHandler.handle(
          error,
          stackTrace: stackTrace,
          postProcessor: (_, msg) {
            EasyLoading.showError(msg ?? 'Failure');
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

  void showShopModalBottomSheet() {
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
        buttonText: '取消',
        callback: NavigatorUtil.pop,
        header: const HpHeader(title: '请选择您的操作', hideCancel: true),
        items: [
          if (StringUtil.isNotBlank(tbConfig?.value))
            SectionItem(
              title: '复制淘口令',
              tips: '直播平台、时间等',
              showBack: false,
              contentPadding: padding,
              innerPadding: padding,
              crossAxisAlignment: crossAxisAlignment,
              onTap: () =>
                  FlutterClipboard.copy(tbConfig!.value!).then((value) {
                EasyLoading.showSuccess('Copied');
                NavigatorUtil.pop();
              }),
            ),
          SectionItem(
            title: '打开淘宝店地址',
            tips: '寒潮啦! 来件卫衣吧~~',
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

  Future<void> _load() async {
    try {
      setState(() => _loading = true);
      final carousels = await CarouselApi.getCarouselList();
      setState(() {
        _loading = false;
        _carousels = carousels;
      });
    } on Exception catch (error, stackTrace) {
      ErrorHandler.handle(
        error,
        stackTrace: stackTrace,
        postProcessor: (_, msg) {
          setState(() {
            _loading = false;
            _error = msg ?? 'Failure';
          });
        },
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
