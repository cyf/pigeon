import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/api/carousel_api.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/color_util.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/l10n/l10n.dart';
import 'package:homing_pigeon/main.dart';
import 'package:homing_pigeon/modules/app/app.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const double carouselHeight = 250;

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool isSliverAppBarExpanded = false;

  List<CarouselModel> _carousels = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        isSliverAppBarExpanded = _scrollController.hasClients &&
            _scrollController.offset > carouselHeight - kToolbarHeight;
      });
    });

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? value) {
        if (kDebugMode) {
          log('A new getInitialMessage event was published!');
        }
      },
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        log('A new onMessageOpenedApp event was published!');
      }
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
      body: _buildScaffoldBody(),
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

  void showShopModalBottomSheet() {
    final configs = BlocProvider.of<AppCubit>(context).state.configs;
    final tbConfig =
        configs.firstWhereOrNull((config) => config.key == 'taobao');

    const crossAxisAlignment = CrossAxisAlignment.center;
    const padding = EdgeInsets.zero;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => ModalBottomSheet(
        button: '取消',
        callback: NavigatorUtil.pop,
        items: [
          const Text(
            '请选择您的操作',
            style: TextStyle(fontSize: 16, color: placeholderTextColor),
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
