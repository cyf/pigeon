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
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isSliverAppBarExpanded = false;

  final accountFocusNode = FocusNode();
  final nicknameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  bool _isAccountFocus = false;
  bool _isNicknameFocus = false;
  bool _isEmailFocus = false;

  List<CarouselModel> _carousels = [];
  bool _loading = false;
  String? _error;

  bool _showPassword = false;
  bool _showRepeatPassword = false;
  bool _isRegistered = false;

  @override
  void initState() {
    super.initState();
    accountFocusNode.addListener(() {
      setState(() {
        _isAccountFocus = accountFocusNode.hasFocus;
      });
    });

    nicknameFocusNode.addListener(() {
      setState(() {
        _isNicknameFocus = nicknameFocusNode.hasFocus;
      });
    });

    emailFocusNode.addListener(() {
      setState(() {
        _isEmailFocus = emailFocusNode.hasFocus;
      });
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
    _accountController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
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
            ),
            if (StringUtil.getValue(
                  roadmapConfig?.value,
                  defaultVal: 'disabled',
                ) ==
                'enabled')
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
                '版本号: ${version!}-${AppConfig.shared.flavor.name}',
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
      backgroundColor: Colors.white,
      expandedHeight: expandedHeight,
      title: expandedHeight == null || isSliverAppBarExpanded
          ? Text(AppLocalizations.of(context).appName)
          : null,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
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
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext ctx1, StateSetter setInnerState) {
            return KeyboardDismisser(
              child: ModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: height - top - buttonHeight - bottom,
                ),
                callback: () => !_isRegistered
                    ? _login(setInnerState)
                    : _register(setInnerState),
                buttonText: !_isRegistered ? '登录' : '注册',
                header: Row(
                  children: [
                    Text(
                      '请填写${!_isRegistered ? '登录' : '注册'}信息',
                      style: const TextStyle(
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
                      onPressed: NavigatorUtil.pop,
                      icon: const Icon(
                        Icons.clear,
                        color: borderColor,
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
                items: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        BaseFormItem(
                          title: '账号',
                          showTip: false,
                          padding: EdgeInsets.zero,
                          child: FormBuilderTextField(
                            name: 'account',
                            focusNode: accountFocusNode,
                            controller: _accountController,
                            cursorColor: primaryColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              helperText: _isRegistered
                                  ? '只能包含英文, 数字或下划线, 且只能以字母开头, 至少8个字符'
                                  : null,
                              helperStyle: const TextStyle(
                                color: secondaryTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              fillColor: secondaryGrayColor,
                              filled: true,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: '请输入账号',
                              ),
                              if (_isRegistered)
                                FormBuilderValidators.match(
                                  r'^[a-zA-Z][a-zA-Z0-9_]{7,}$',
                                  errorText:
                                      '账号只能包含英文,数字或下划线, 且只能以字母开头, 至少8个字符',
                                ),
                              // TODO(kjxbyz): 与数据库联动，账号唯一
                            ]),
                          ).nestedPadding(
                            padding: const EdgeInsets.only(top: 8),
                          ),
                        ),
                        if (_isRegistered) ...[
                          BaseFormItem(
                            title: '昵称',
                            required: false,
                            showTip: false,
                            child: FormBuilderTextField(
                              name: 'nickname',
                              focusNode: nicknameFocusNode,
                              controller: _nicknameController,
                              cursorColor: primaryColor,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              onChanged: (value) {
                                setInnerState(() {});
                              },
                              decoration: InputDecoration(
                                suffixIcon: (_isNicknameFocus &&
                                        _nicknameController.text.isNotEmpty)
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: primaryGrayColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          splashRadius: 2,
                                          onPressed: () {
                                            // Clear everything in the text field
                                            _nicknameController.clear();
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
                                hintText: '请输入昵称',
                                contentPadding: const EdgeInsets.all(8),
                                fillColor: secondaryGrayColor,
                                filled: true,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.maxLength(
                                  20,
                                  errorText: '昵称长度不能大于20',
                                ),
                              ]),
                            ).nestedPadding(
                              padding: const EdgeInsets.only(top: 8),
                            ),
                          ),
                          BaseFormItem(
                            title: '邮箱',
                            showTip: false,
                            child: FormBuilderTextField(
                              name: 'email',
                              focusNode: emailFocusNode,
                              controller: _emailController,
                              cursorColor: primaryColor,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              onChanged: (value) {
                                setInnerState(() {});
                              },
                              decoration: InputDecoration(
                                suffixIcon: (_isEmailFocus &&
                                        _emailController.text.isNotEmpty)
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: primaryGrayColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          splashRadius: 2,
                                          onPressed: () {
                                            // Clear everything in the text field
                                            _emailController.clear();
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
                                hintText: '请输入邮箱',
                                contentPadding: const EdgeInsets.all(8),
                                fillColor: secondaryGrayColor,
                                filled: true,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: '请输入邮箱',
                                ),
                                FormBuilderValidators.email(
                                  errorText: '邮箱格式错误',
                                ),
                                // TODO(kjxbyz): 与数据库联动，邮箱唯一
                              ]),
                            ).nestedPadding(
                              padding: const EdgeInsets.only(top: 8),
                            ),
                          ),
                        ],
                        BaseFormItem(
                          title: '密码',
                          showTip: false,
                          child: FormBuilderTextField(
                            name: 'password',
                            controller: _passwordController,
                            cursorColor: primaryColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              helperText: _isRegistered ? '至少8个字符' : null,
                              helperStyle: const TextStyle(
                                color: secondaryTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              fillColor: secondaryGrayColor,
                              filled: true,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: '请输入密码',
                              ),
                              FormBuilderValidators.minLength(
                                8,
                                errorText: '请至少输入8个字符',
                              ),
                            ]),
                          ).nestedPadding(
                            padding: const EdgeInsets.only(top: 8),
                          ),
                        ),
                        if (_isRegistered)
                          BaseFormItem(
                            title: '重复密码',
                            showTip: false,
                            child: FormBuilderTextField(
                              name: 'repeatPassword',
                              controller: _repeatPasswordController,
                              cursorColor: primaryColor,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              obscureText: !_showRepeatPassword,
                              onChanged: (value) {
                                setInnerState(() {});
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setInnerState(
                                      () => _showRepeatPassword =
                                          !_showRepeatPassword,
                                    );
                                  },
                                  icon: Icon(
                                    _showRepeatPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: borderColor,
                                    size: 18,
                                  ),
                                ),
                                hintText: '请再次输入密码',
                                helperStyle: const TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: const EdgeInsets.all(8),
                                fillColor: secondaryGrayColor,
                                filled: true,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: '请再次输入密码',
                                ),
                                FormBuilderValidators.minLength(
                                  8,
                                  errorText: '请至少输入8个字符',
                                ),
                                FormBuilderValidators.equal(
                                  _passwordController.text,
                                  errorText: '两次输入的密码不一样',
                                ),
                              ]),
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
                                          Colors.white,
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
                                              style: TextStyle(
                                                color: primaryTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
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
                                              style: TextStyle(
                                                color: primaryTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
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
                          style: const TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: !_isRegistered ? '去注册' : '去登录',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              setInnerState(
                                () => _isRegistered = !_isRegistered,
                              );
                            },
                          style: const TextStyle(
                            color: secondaryTextColor,
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
              callback: () => _logout(setInnerState),
              buttonText: '退出',
            ),
          );
        },
      ),
    );
  }

  // 登录接口
  void _login(StateSetter setInnerState) {
    if (_formKey.currentState!.validate()) {
      final fields = _formKey.currentState!.instantValue;
      final account = fields['account'] as String;
      final password = fields['password'] as String;

      EasyLoading.show();
      AuthApi.login(account: account, password: password).then((value) {
        if (value != null) {
          NavigatorUtil.pop();
          EasyLoading.showSuccess('Success');
          _accountController.clear();
          _passwordController.clear();
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
  void _register(StateSetter setInnerState) {
    if (_formKey.currentState!.validate()) {
      final fields = _formKey.currentState!.instantValue;
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
          _accountController.clear();
          _nicknameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _repeatPasswordController.clear();
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
  void _logout(StateSetter setInnerState) {
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
