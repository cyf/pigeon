import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:homing_pigeon/common/api/feedback_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/utils/upload_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reorderables/reorderables.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final _formKey = GlobalKey<FormState>();
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  bool _isTitleFocus = false;
  bool _isDescriptionFocus = false;

  List<FeedbackModel> items = [];
  bool loading = false;
  int page = 1;
  int total = 0;

  List<FileWrapper> _fileWrappers = [];

  @override
  void initState() {
    super.initState();
    titleFocusNode.addListener(() {
      setState(() {
        _isTitleFocus = titleFocusNode.hasFocus;
      });
    });
    descriptionFocusNode.addListener(() {
      setState(() {
        _isDescriptionFocus = descriptionFocusNode.hasFocus;
      });
    });

    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: HpAppBar(
        titleName: '意见或建议',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '无论您遇到任何问题、意见或建议，均可点击如下按钮进行反馈。',
            style: TextStyle(
              fontSize: 18,
              color: primaryTextColor,
            ),
          ).nestedPadding(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              minimumSize: MaterialStateProperty.all(Size.zero),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: showUploadBottomSheet,
            child: const Text(
              '点击反馈',
              style: TextStyle(fontSize: 16),
            ),
          ).nestedCenter(),
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
      return ListView.builder(
        padding: EdgeInsets.only(top: 20, bottom: bottom),
        itemCount: items.length,
        itemBuilder: (context, index) => Text('$index'),
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
    const spacing = 8.0;
    const padding = 10.0;
    final width = MediaQuery.of(context).size.width - padding * 2;
    final itemWidth = ((width - spacing * 2) / 3).floorToDouble();

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setInnerState) {
          final items = _fileWrappers
              .map(
                (element) {
                  return Image.asset(
                    element.file.path,
                    errorBuilder: (context, url, error) => const Icon(
                      Icons.error,
                      color: errorTextColor,
                      size: 24,
                    ),
                  ).nestedSizedBox(width: itemWidth, height: itemWidth);
                },
              )
              .cast<Widget>()
              .toList();

          if (items.length < 9) {
            items.add(
              const Icon(
                Icons.add,
                size: 40,
                color: primaryColor,
              )
                  .nestedCenter()
                  .nestedColoredBox(color: secondaryGrayColor)
                  .nestedSizedBox(width: itemWidth, height: itemWidth)
                  .nestedInkWell(onTap: () => _pickImages(setInnerState)),
            );
          }

          return KeyboardDismisser(
            child: ModalBottomSheet(
              shrinkWrap: false,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              callback: _submit,
              button: '提交',
              items: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BaseFormItem(
                        title: '标题',
                        showTip: false,
                        child: TextFormField(
                          focusNode: titleFocusNode,
                          controller: _titleController,
                          cursorColor: primaryColor,
                          autocorrect: false,
                          onChanged: (value) {
                            setInnerState(() {});
                          },
                          maxLines: 3,
                          maxLength: 100,
                          decoration: InputDecoration(
                            suffixIcon: (_isTitleFocus &&
                                _titleController.text.isNotEmpty)
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
                                  _titleController.clear();
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
                            suffixIconConstraints:
                            const BoxConstraints(maxWidth: 30, maxHeight: 30),
                            hintText: '请输入标题',
                            counterText: StringUtil.empty,
                            contentPadding: const EdgeInsets.all(8),
                            fillColor: secondaryGrayColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (StringUtil.isBlank(value)) {
                              return '请输入标题';
                            }
                            return null;
                          },
                        ).nestedPadding(
                          padding: const EdgeInsets.only(top: 8),
                        ),
                      ),
                      BaseFormItem(
                        title: '描述',
                        showTip: false,
                        child: TextFormField(
                          focusNode: descriptionFocusNode,
                          controller: _descriptionController,
                          cursorColor: primaryColor,
                          autocorrect: false,
                          onChanged: (value) {
                            setInnerState(() {});
                          },
                          maxLines: 10,
                          maxLength: 500,
                          decoration: InputDecoration(
                            suffixIcon: (_isDescriptionFocus &&
                                _descriptionController.text.isNotEmpty)
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
                                  _descriptionController.clear();
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
                            suffixIconConstraints:
                            const BoxConstraints(maxWidth: 30, maxHeight: 30),
                            hintText: '请输入描述',
                            counterText: StringUtil.empty,
                            contentPadding: const EdgeInsets.all(8),
                            fillColor: secondaryGrayColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (StringUtil.isBlank(value)) {
                              return '请输入描述';
                            }
                            return null;
                          },
                        ).nestedPadding(
                          padding: const EdgeInsets.only(top: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                ReorderableWrap(
                  spacing: spacing,
                  runSpacing: 4,
                  onReorder: _onReorder,
                  children: items,
                ).nestedPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImages(StateSetter setInnerState) async {
    Map<Permission, PermissionStatus> statuses;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        statuses = await [Permission.photos, Permission.videos].request();
      } else {
        statuses = await [Permission.storage].request();
      }
    } else {
      statuses = await [Permission.photos].request();
    }

    if (kDebugMode) {
      print('statuses: $statuses');
    }

    final statusList = statuses.values.toList();
    final denied = statusList.every(
      (status) => [PermissionStatus.permanentlyDenied, PermissionStatus.denied]
          .contains(status),
    );
    if (denied) {
      if (!context.mounted) return;
      Dialogs.showGalleryPermissionDialog(context);
      return;
    }

    await _gotoPickImages(setInnerState);
  }

  Future<void> _gotoPickImages(StateSetter setInnerState) async {
    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets:
            _fileWrappers.map((fileWrapper) => fileWrapper.asset).toList(),
      ),
    );
    if (assets != null && assets.isNotEmpty) {
      try {
        final fileWrapperFutures = assets.map((asset) async {
          final file = await asset.originFile;
          final name = await asset.titleAsync;
          return file != null
              ? FileWrapper(asset: asset, file: file, name: name)
              : null;
        }).toList();

        final fileWrappers =
            (await Future.wait(fileWrapperFutures)).whereNotNull().toList();
        final limiter = fileWrappers.firstWhereOrNull(
          (fileWrapper) {
            final fileSize = fileWrapper.file.lengthSync();
            return fileSize < 50 * 1024 || fileSize > 20 * 1024 * 1024;
          },
        );
        if (limiter != null) {
          await EasyLoading.showToast(
            'The uploaded images or videos must be between 50KB and 20MB.',
          );
          return;
        }

        setInnerState(() => _fileWrappers = fileWrappers);
      } on RequestedException catch (error, stackTrace) {
        log(error.msg, stackTrace: stackTrace);
        await EasyLoading.showError(error.msg);
      }
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await EasyLoading.show();
        final files = <EmojiParam>[];
        if (_fileWrappers.isNotEmpty) {
          final uploadFileFutures = _fileWrappers
              .map(
                (fileWrapper) async =>
                    UploadUtil.uploadOSS(fileWrapper: fileWrapper),
              )
              .toList();
          final fileModels = (await Future.wait(uploadFileFutures)).toList();
          if (fileModels.isNotEmpty) {
            files.addAll(
              fileModels.map(
                (fileModel) => EmojiParam(
                  image: fileModel.url,
                  text: fileModel.oldFileName,
                  type: fileModel.type,
                  size: fileModel.fileSize,
                ),
              ),
            );
          }
        }
        // TODO(kjxbyz): submit api

        await EasyLoading.showSuccess('Success');
        _load();
      } on RequestedException catch (error, stackTrace) {
        log(error.msg, stackTrace: stackTrace);
        await EasyLoading.showError(error.msg);
      }
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {});
  }

  void _load({Operation operation = Operation.none}) {
    // var currentPage = page;
    // if (operation == Operation.none) {
    //   currentPage = 1;
    //   setState(() => loading = true);
    //   EasyLoading.show();
    // } else if (operation == Operation.refresh) {
    //   currentPage = 1;
    // } else if (operation == Operation.load) {
    //   if (items.length >= total) {
    //     _controller.finishLoad(IndicatorResult.noMore);
    //     return;
    //   }
    //   currentPage++;
    // }
    //
    // FeedbackApi.getFeedbackList(page: currentPage).then(
    //   (data) {
    //     if (operation == Operation.none) {
    //       EasyLoading.dismiss();
    //       setState(() {
    //         loading = false;
    //         page = data?.page ?? 1;
    //         total = data?.pageInfo?.total ?? 0;
    //         items = data?.items ?? [];
    //       });
    //     } else if (operation == Operation.refresh) {
    //       _controller.finishRefresh();
    //       setState(() {
    //         page = data?.page ?? 1;
    //         total = data?.pageInfo?.total ?? 0;
    //         items = data?.items ?? [];
    //       });
    //     } else if (operation == Operation.load) {
    //       _controller.finishLoad();
    //       setState(() {
    //         page = data?.page ?? 1;
    //         total = data?.pageInfo?.total ?? 0;
    //         items = items + (data?.items ?? []);
    //       });
    //     }
    //   },
    // ).onError<RequestedException>((err, stackTrace) {
    //   if (operation == Operation.none) {
    //     setState(() => loading = false);
    //     EasyLoading.showError(err.msg);
    //   } else if (operation == Operation.refresh) {
    //     _controller.finishRefresh(IndicatorResult.fail);
    //   } else if (operation == Operation.load) {
    //     _controller.finishLoad(IndicatorResult.fail);
    //   }
    // });
  }
}
