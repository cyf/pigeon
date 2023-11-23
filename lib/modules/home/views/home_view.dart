import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/main.dart';
import 'package:homing_pigeon/modules/home/home.dart';
import 'package:homing_pigeon/theme/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const double carouselHeight = 250;

class _HomeViewState extends State<HomeView> {
  late ScrollController scrollController;
  bool isSliverAppBarExpanded = false;

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
      backgroundColor: Colors.white,
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;
    final width = MediaQuery.of(context).size.width;
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
              itemCount: 5,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Text(itemIndex.toString())
                          .nestedCenter()
                          .nestedSizedBox(width: width)
                          .nestedDecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
              options: CarouselOptions(
                height: carouselHeight + statusBarHeight,
                viewportFraction: 1,
                // enableInfiniteScroll: false,
              ),
            ),
          ),
        ),
        Section(
          title: const Text(
            '主要功能',
            style: TextStyle(color: secondaryTextColor, fontSize: 16),
          )
              .nestedPadding(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 6),
              )
              .nestedColoredBox(color: secondaryGrayColor),
          items: [
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
          ],
        ),
        Section(
          title: const Text(
            '其他功能',
            style: TextStyle(color: secondaryTextColor, fontSize: 16),
          )
              .nestedPadding(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 6),
              )
              .nestedColoredBox(color: secondaryGrayColor),
          items: [
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
            SectionItem(
              title: '直播信息/提醒群',
              tips: '直播平台、时间',
              backFunc: () => {},
            )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                )
                .nestedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 4),
                )
                .nestedDecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                )
                .nestedSizedBox(height: 68),
          ],
        ),
      ],
    ).nestedPadding(padding: EdgeInsets.only(bottom: bottom));
  }
}

@immutable
class Carousel {
  const Carousel({
    required this.img,
    required this.order,
  });

  Carousel.fromJson(Map<String, Object?> json)
      : this(
          img: json['img']! as String,
          order: json['order']! as int,
        );

  final String img;
  final int order;

  Map<String, Object?> toJson() {
    return {
      'img': img,
      'order': order,
    };
  }
}
