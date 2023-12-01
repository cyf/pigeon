import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/common/api/social_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
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

  List<CardItem> items = [];
  bool loading = false;

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
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: HpAppBar(
        titleWidget: const Text('社交'),
      ),
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(),
        onRefresh: () => _load(operation: Operation.refresh),
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
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(4)),
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
                            MaterialStateProperty.all(Colors.transparent),
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: _load,
                      child: const Text(
                        '点击以重新加载',
                        style: TextStyle(
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

  void _load({Operation operation = Operation.none}) {
    setState(() => loading = true);
    if (operation == Operation.none) {
      EasyLoading.show();
    }
    SocialApi.getSocialCardList().then(
      (data) {
        setState(() {
          loading = false;
          items = data;
        });
        if (operation == Operation.none) {
          EasyLoading.dismiss();
        } else if (operation == Operation.refresh) {
          _controller.finishRefresh();
        }
      },
    ).onError<RequestedException>((error, stackTrace) {
      setState(() => loading = false);
      if (operation == Operation.none) {
        EasyLoading.showError(error.msg);
      } else if (operation == Operation.refresh) {
        _controller.finishRefresh(IndicatorResult.fail);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
