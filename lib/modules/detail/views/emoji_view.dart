import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homing_pigeon/common/api/emoji_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/upload_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
        titleName: '表情库～',
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
        callback: _uploadFiles,
        button: '上传',
        items: [
          const Text('content').nestedTap(pickImages),
        ],
      ),
    );
  }

  Future<void> pickImages() async {
    PermissionStatus status;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
      if (!context.mounted) return;
      showGalleryPermissionDialog(status);
      return;
    }

    if (status.isDenied) {
      return;
    }

    await _gotoPickImages();
  }

  Future<void> _gotoPickImages() async {
    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        requestType: RequestType.image,
      ),
    );
    if (assets != null && assets.isNotEmpty) {
      try {
        final fileWrapperFutures = assets.map((asset) async {
          final file = await asset.originFile;
          final name = await asset.titleAsync;
          return file != null ? FileWrapper(file: file, name: name) : null;
        }).toList();

        final fileWrappers =
            (await Future.wait(fileWrapperFutures)).whereNotNull().toList();
        final limiter = fileWrappers.firstWhereOrNull(
          (fileWrapper) {
            final fileSize = fileWrapper.file.lengthSync();
            return fileSize < 50 * 1024 || fileSize > 15 * 1024 * 1024;
          },
        );
        if (limiter != null) {
          await EasyLoading.showToast(
            'The uploaded image must be between 50KB and 15MB.',
          );
          return;
        }

        final uploadFileFutures = fileWrappers
            .map(
              (fileWrapper) async =>
                  UploadUtil.uploadOSS(fileWrapper: fileWrapper),
            )
            .toList();

        await EasyLoading.show();
        final fileModels = (await Future.wait(uploadFileFutures)).toList();
        if (fileModels.isNotEmpty) {
          final emojis = fileModels
              .map(
                (fileModel) => EmojiModel(
                  image: fileModel.url,
                  text: fileModel.oldFileName,
                  type: fileModel.type,
                  size: fileModel.fileSize,
                ),
              )
              .toList();
          await EmojiApi.multiAddEmoji(emojis);
          if (context.mounted) {
            NavigatorUtil.pop(context);
          }
        }
        await EasyLoading.showSuccess('Success');
        _load();
      } on RequestedException catch (error, stackTrace) {
        log(error.msg, stackTrace: stackTrace);
        await EasyLoading.showError(error.msg);
      }
    }
  }

  Future<void> _uploadFiles() async {}

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

  void showGalleryPermissionDialog(PermissionStatus status) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Allow access to your album',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: const Text(
          'Please go to your phone Settings to grant Homing Pigeon the permission to visit your album.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Row(
            children: [
              const Text(
                'Ignore',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 16,
                  height: 1.375,
                ),
              )
                  .nestedPadding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
              )
                  .nestedTap(() {
                NavigatorUtil.pop(context);
              }).nestedExpanded(),
              const Text(
                'Turn On',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  height: 1.375,
                ),
              )
                  .nestedPadding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                  )
                  .nestedDecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(left: BorderSide(color: borderColor)),
                    ),
                  )
                  .nestedTap(() async {
                NavigatorUtil.pop(context);
                await AppSettings.openAppSettings();
              }).nestedExpanded(),
            ],
          ).nestedDecoratedBox(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: borderColor)),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsOverflowButtonSpacing: 0,
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
