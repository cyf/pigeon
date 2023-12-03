import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homing_pigeon/common/api/emoji_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/theme/colors.dart';

class EmojiView extends StatefulWidget {
  const EmojiView({super.key});

  @override
  State<EmojiView> createState() => _EmojiViewState();
}

class _EmojiViewState extends State<EmojiView> {
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  List<EmojiModel> items = [];
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
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: HpAppBar(
        titleWidget: const Text('表情库～'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '欢迎投稿，嗷呜~',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ),
          ).nestedPadding(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
          ),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 16, color: primaryTextColor),
              children: [
                const TextSpan(text: '欢迎'),
                TextSpan(
                  text: ' [点击此处] ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = showUploadBottomSheet,
                  style: const TextStyle(color: primaryColor),
                ),
                const TextSpan(text: '投稿，可以是表情包，可以是文案创意，也可以是一些令猫尴尬的图片或截图等~😄'),
              ],
            ),
          ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
          EasyRefresh(
            controller: _controller,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onRefresh: () => _load(operation: Operation.refresh),
            onLoad: () => _load(operation: Operation.load),
            child: _buildBody(),
          ).nestedExpanded(),
        ],
      ).nestedPadding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: bottom,
        ),
      ),
    );
  }

  Widget _buildBody() {
    final bottom = MediaQuery.of(context).padding.bottom;
    if (!loading && items.isNotEmpty) {
      return MasonryGridView.count(
        padding: EdgeInsets.only(top: 20, bottom: bottom),
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemCount: items.length,
        itemBuilder: (context, index) => EmojiCard(
          emojis: items,
          page: index,
        ),
      );
    }

    if (!loading && items.isEmpty) {
      final height = MediaQuery.of(context).size.height;
      return NoData(
        icon: IconButton.outlined(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
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
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: _load,
          child: const Text(
            '没有数据, 点击以重新加载',
            style: TextStyle(
              fontSize: 12,
              color: placeholderTextColor,
            ),
          ),
        ),
      ).nestedSizedBox(height: height / 2 + 66).nestedSingleChildScrollView();
    }

    return const SizedBox();
  }

  void showUploadBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => ModalBottomSheet(
        shrinkWrap: false,
        callback: () {},
        button: '上传',
        items: const [
          Text('content'),
        ],
      ),
    );
  }

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

    EmojiApi.getEmojiList(page: currentPage).then(
      (data) {
        if (operation == Operation.none) {
          EasyLoading.dismiss();
          setState(() {
            loading = false;
            page = data?.page ?? 1;
            total = data?.pageInfo?.total ?? 0;
            items = data?.items ?? [];
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
    ).onError<RequestedException>((err, stackTrace) {
      if (operation == Operation.none) {
        setState(() => loading = false);
        EasyLoading.showError(err.msg);
      } else if (operation == Operation.refresh) {
        _controller.finishRefresh(IndicatorResult.fail);
      } else if (operation == Operation.load) {
        _controller.finishLoad(IndicatorResult.fail);
      }
    });
  }
}
