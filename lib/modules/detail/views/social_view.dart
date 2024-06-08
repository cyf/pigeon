import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/api/social_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/http/utils/handle_errors.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/i18n/i18n.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/theme/colors.dart';

class SocialView extends StatefulWidget {
  const SocialView({super.key});

  @override
  State<SocialView> createState() => _SocialViewState();
}

class _SocialViewState extends State<SocialView>
    with AutomaticKeepAliveClientMixin {
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  List<SocialModel> items = [];
  bool loading = false;
  int page = 1;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: HpAppBar(
        isDark: isDark,
        titleName: t.pages.social.title,
      ),
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(),
        onRefresh: () => _load(operation: Operation.refresh),
        onLoad: () => _load(operation: Operation.load),
        child: !loading && items.isNotEmpty
            ? ListView.separated(
                itemCount: items.length,
                padding: EdgeInsets.only(top: 20, bottom: bottom),
                itemBuilder: (BuildContext context, int index) =>
                    SocialCard(item: items[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 14),
              )
            : !loading && items.isEmpty
                ? NoData(
                    icon: IconButton.outlined(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        padding:
                            WidgetStateProperty.all(const EdgeInsets.all(4)),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: _load,
                      icon: const Icon(
                        Icons.cached,
                        color: placeholderTextColor,
                      ),
                    ),
                    title: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: _load,
                      child: Text(
                        t.common.noData,
                        style: const TextStyle(
                          fontSize: 12,
                          color: placeholderTextColor,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }

  /// 数据加载
  void _load({Operation operation = Operation.none}) {
    var currentPage = page;
    if (operation == Operation.none) {
      currentPage = 1;
      setState(() => loading = true);
      EasyLoading.show();
    } else if (operation == Operation.refresh) {
      currentPage = 1;
    } else if (operation == Operation.load) {
      if (items.length >= total) {
        _controller.finishLoad(IndicatorResult.noMore);
        return;
      }
      currentPage++;
    }

    SocialApi.getSocialCardList(page: currentPage).then(
      (data) {
        if (operation == Operation.none) {
          EasyLoading.dismiss();
          setState(() {
            loading = false;
            page = data?.page ?? 1;
            total = data?.pageInfo?.total ?? 0;
            items = data?.items ?? [];
                // [
                //   SocialModel(
                //     title: 'hahahahha',
                //     subtitles: [
                //       SubTitle(title: 'hahahah'),
                //     ],
                //     tips: [
                //       Link(type: LinkType.link, href: 'https://baidu.com'),
                //       Link(type: LinkType.text, text: 'hahahah'),
                //     ],
                //     descriptions: [
                //       Description(
                //         name: 'hahah',
                //         links: [
                //           Link(type: LinkType.link, href: 'https://baidu.com'),
                //           Link(type: LinkType.text, text: 'hahahah'),
                //         ],
                //       ),
                //     ],
                //   )
                // ];
          });
        } else if (operation == Operation.refresh) {
          _controller.finishRefresh();
          setState(() {
            page = data?.page ?? 1;
            total = data?.pageInfo?.total ?? 0;
            items = data?.items ?? [];
          });
        } else if (operation == Operation.load) {
          _controller.finishLoad();
          setState(() {
            page = data?.page ?? 1;
            total = data?.pageInfo?.total ?? 0;
            items = items + (data?.items ?? []);
          });
        }
      },
    ).onError<Exception>((error, stackTrace) {
      final context = AppNavigator.key.currentContext!;
      final t = Translations.of(context);
      ErrorHandler.handle(
        error,
        stackTrace: stackTrace,
        postProcessor: (_, msg) {
          if (operation == Operation.none) {
            setState(() => loading = false);
            EasyLoading.showError(msg ?? t.common.failure);
          } else if (operation == Operation.refresh) {
            _controller.finishRefresh(IndicatorResult.fail);
          } else if (operation == Operation.load) {
            _controller.finishLoad(IndicatorResult.fail);
          }
        },
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
