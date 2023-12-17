import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/api/carousel_api.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/color_util.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/gen/assets.gen.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/main.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isSliverAppBarExpanded = false;

  final accountFocusNode = FocusNode();
  bool _isAccountFocus = false;

  List<CarouselModel> _carousels = [];
  bool _loading = false;
  String? _error;

  bool _showPassword = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    accountFocusNode.addListener(() {
      setState(() {
        _isAccountFocus = accountFocusNode.hasFocus;
      });
    });

    _scrollController.addListener(() {
      setState(() {
        isSliverAppBarExpanded = _scrollController.hasClients &&
            _scrollController.offset > carouselHeight - kToolbarHeight;
      });
    });

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? value) {
        printDebugLog('A new getInitialMessage event was published!');
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printDebugLog('A new onMessageOpenedApp event was published!');
    });

    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildScaffoldBody(),
      floatingActionButton: IconButton.filled(
        onPressed: showLoginBottomSheet,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(
            !_isAuthenticated ? primaryBackgroundColor : primaryGrayColor,
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
    );
  }

  Widget _buildScaffoldBody() {
    final configs = BlocProvider.of<AppCubit>(context).state.configs;
    final roadmapConfig =
        configs.firstWhereOrNull((config) => config.key == 'roadmap');
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
                '版本号: ${version!}',
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
      context: AppNavigator.key.currentContext!,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext ctx1, StateSetter setInnerState) {
          return KeyboardDismisser(
            child: ModalBottomSheet(
              constraints: BoxConstraints(maxHeight: height - top - bottom),
              callback: () => _login(setInnerState),
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
                      onPressed: NavigatorUtil.pop,
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

  void _login(StateSetter setInnerState) {
    if (_formKey.currentState?.validate() ?? false) {}
  }

  void showShopModalBottomSheet() {
    final configs = BlocProvider.of<AppCubit>(context).state.configs;
    final tbConfig =
        configs.firstWhereOrNull((config) => config.key == 'taobao');

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
        items: [
          const Text(
            '请选择您的操作',
            style: TextStyle(fontSize: 16, color: primaryTextColor),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
              .nestedCenter()
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
              .nestedSizedBox(height: 64),
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
    } on RequestedException catch (error, stackTrace) {
      printErrorStackLog(error, stackTrace);
      setState(() {
        _loading = false;
        _error = error.msg;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
