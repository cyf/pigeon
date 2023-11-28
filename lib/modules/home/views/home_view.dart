import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/manager.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/main.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const double carouselHeight = 250;

class _HomeViewState extends State<HomeView> {
  late ScrollController scrollController;
  bool isSliverAppBarExpanded = false;

  List<Carousel> carousels = List.generate(
    5,
    (index) => Carousel(
      image: 'https://images.unsplash.com/photo-1700902741852-ecf2bd2c26eb',
      order: index,
      href: 'https://www.google.com',
    ),
  );

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          isSliverAppBarExpanded = scrollController.hasClients &&
              scrollController.offset > carouselHeight - kToolbarHeight;
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
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;
    final width = MediaQuery.of(context).size.width;
    final version = AppManager.instance.version;
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          pinned: true,
          stretch: true,
          backgroundColor: Colors.white,
          expandedHeight: carouselHeight,
          title: isSliverAppBarExpanded
              ? const Text('pinned header height')
              : null,
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
          flexibleSpace: FlexibleSpaceBar(
            // centerTitle: true,
            collapseMode: CollapseMode.pin,
            background: CarouselSlider.builder(
              itemCount: carousels.length,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) =>
                  CachedNetworkImage(
                imageUrl: carousels[itemIndex].image,
                imageBuilder: (context, imageProvider) => Container(
                  width: width,
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
                ).nestedSizedBox(width: 40, height: 40).nestedCenter(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ).nestedTap(() async {
                final carousel = carousels[itemIndex];
                if (StringUtil.isNotBlank(carousel.href)) {
                  final uri = Uri.tryParse(carousel.href!);
                  if (uri != null) {
                    await launchUrl(uri);
                  }
                }
              }),
              options: CarouselOptions(
                autoPlay: true,
                height: carouselHeight + statusBarHeight,
                viewportFraction: 1,
                // enableInfiniteScroll: false,
              ),
            ),
          ),
        ),
        Section(
          title: '主要功能',
          items: [
            SectionItem(
              title: '电影打分系统',
              tips: '给看过的电影打个分吧~~',
              onTap: () => {},
            ),
            SectionItem(
              title: '直播预告',
              tips: '查看详情',
              onTap: () => {},
            ),
            SectionItem(
              title: '开播通知设置',
              onTap: () => {},
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
              onTap: () => {},
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
              onTap: () => {},
            ),
            SectionItem(
              title: '意见/建议',
              onTap: () => {},
              showBorder: false,
            ),
          ],
        ),
        if (StringUtil.isNotBlank(version))
          SliverList.list(
            children: [
              Text(
                'Version: ${version!}',
                style: const TextStyle(fontSize: 12, color: secondaryTextColor),
                textAlign: TextAlign.center,
              ).nestedPadding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
              ),
            ],
          ),
      ],
    ).nestedPadding(padding: EdgeInsets.only(bottom: bottom));
  }

  void showShopModalBottomSheet() {
    final bottom = MediaQuery.of(context).padding.bottom;
    const crossAxisAlignment = CrossAxisAlignment.center;
    const padding = EdgeInsets.zero;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => ModalBottomSheetPopup(
        physics: const NeverScrollableScrollPhysics(),
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
          SectionItem(
            title: '复制淘口令',
            tips: '直播平台、时间等',
            showBack: false,
            contentPadding: padding,
            innerPadding: padding,
            outerPadding: padding,
            crossAxisAlignment: crossAxisAlignment,
            onTap: () => FlutterClipboard.copy('text').then((value) {
              EasyLoading.showSuccess('Copied');
              NavigatorUtil.pop(context);
            }),
          ),
          SectionItem(
            title: '复制淘宝店地址',
            tips: '寒潮啦! 来件卫衣吧~~',
            tipsColor: errorTextColor,
            showBack: false,
            showBorder: false,
            contentPadding: padding,
            innerPadding: padding,
            outerPadding: padding,
            crossAxisAlignment: crossAxisAlignment,
            onTap: () async {
              if (mounted) {
                NavigatorUtil.pop(context);
              }
              await launchUrl(Uri.parse('https://chenyifaer.taobao.com'));
            },
          ),
          TextButton(
            onPressed: () => NavigatorUtil.pop(context),
            child: const Text(
              '取消',
              style: TextStyle(fontSize: 18, color: primaryTextColor),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
                .nestedCenter()
                .nestedSizedBox(height: 64)
                .nestedPadding(padding: EdgeInsets.only(bottom: bottom)),
          ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
        ],
      ),
    );
  }
}

class ModalBottomSheetPopup extends StatelessWidget {
  const ModalBottomSheetPopup({
    required this.items,
    this.physics,
    super.key,
  });

  final List<Widget> items;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: items.length,
      physics: physics,
      itemBuilder: (context, index) => items[index],
    );
  }
}

@immutable
class Carousel {
  const Carousel({
    required this.image,
    required this.order,
    this.href,
  });

  Carousel.fromJson(Map<String, Object?> json)
      : this(
          image: json['image']! as String,
          order: json['order']! as int,
          href: json['href']! as String?,
        );

  final String image;
  final int order;
  final String? href;

  Map<String, Object?> toJson() {
    return {
      'image': image,
      'order': order,
      'href': href,
    };
  }
}
