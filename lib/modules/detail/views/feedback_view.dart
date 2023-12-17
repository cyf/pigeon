import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/common/api/feedback_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
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
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: '无论您遇到任何问题、意见或建议，均可'),
                TextSpan(
                  text: '[点击此处]',
                  style: const TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = showUploadBottomSheet,
                ),
                const TextSpan(text: '进行反馈。'),
              ],
            ),
            style: const TextStyle(
              fontSize: 18,
              color: primaryTextColor,
            ),
          ).nestedPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          // TextButton(
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all(primaryColor),
          //     foregroundColor: MaterialStateProperty.all(Colors.white),
          //     minimumSize: MaterialStateProperty.all(Size.zero),
          //     padding: MaterialStateProperty.all(
          //       const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          //     ),
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          //   onPressed: showUploadBottomSheet,
          //   child: const Text(
          //     '点击反馈',
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ).nestedCenter(),
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
    if (!loading && items.isNotEmpty) {
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items.elementAt(index);
          return FeedbackCard(
            feedback: item,
          ).nestedTap(
            () => NavigatorUtil.push(
              FeedbackDetailView(
                id: StringUtil.getValue(item.id),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 10,
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
    const spacing = 8.0;
    const padding = 10.0;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;
    final contentWidth = width - padding * 2;
    final itemWidth = ((contentWidth - spacing * 2) / 3).floorToDouble();

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setInnerState) {
          final items = _fileWrappers
              .mapIndexed(
                (index, element) {
                  if (kDebugMode) {
                    print(element.file.path);
                  }
                  return Stack(
                    children: [
                      Image.file(
                        element.file,
                        fit: BoxFit.cover,
                        errorBuilder: (context, url, error) => const Icon(
                          Icons.error,
                          color: errorTextColor,
                          size: 24,
                        ),
                      ).nestedSizedBox(width: itemWidth, height: itemWidth),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: const Icon(
                          Icons.clear,
                          color: warnTextColor,
                          size: 14,
                        )
                            .nestedDecoratedBox(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(9),
                              ),
                            )
                            .nestedSizedBox(width: 18, height: 18)
                            .nestedTap(
                              () => setInnerState(
                                () => _fileWrappers = _fileWrappers
                                  ..removeAt(index),
                              ),
                            ),
                      ),
                    ],
                  );
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
              constraints: BoxConstraints(maxHeight: height - top - bottom),
              callback: _submit,
              buttonText: '提交',
              items: [
                Row(
                  children: [
                    const Text(
                      '请填写反馈内容',
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
                        title: '标题',
                        showTip: false,
                        padding: EdgeInsets.zero,
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
                            suffixIconConstraints: const BoxConstraints(
                              maxWidth: 30,
                              maxHeight: 30,
                            ),
                            hintText: '请输入标题',
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
                            suffixIconConstraints: const BoxConstraints(
                              maxWidth: 30,
                              maxHeight: 30,
                            ),
                            hintText: '请输入描述',
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
                ).nestedPadding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                ),
                BaseFormItem(
                  title: '图片或视频',
                  showTip: false,
                  required: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '您最多可以上传9张图片或视频('),
                            TextSpan(
                              text: '图片大小必须在50KB到15MB之间, 视频大小必须在50KB到20MB之间',
                              style: TextStyle(
                                color: warnTextColor,
                              ),
                            ),
                            TextSpan(text: ')'),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: placeholderTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ReorderableWrap(
                        spacing: spacing,
                        runSpacing: 4,
                        onReorder: (int oldIndex, int newIndex) =>
                            _onReorder(setInnerState, oldIndex, newIndex),
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        children: items,
                      ).nestedPadding(
                        padding: const EdgeInsets.only(top: 8),
                      ),
                    ],
                  ).nestedPadding(
                    padding: const EdgeInsets.only(top: 8),
                  ),
                ).nestedPadding(
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
      Dialogs.showGalleryPermissionDialog();
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

        bool tester(FileWrapper fileWrapper) {
          final fileSize = fileWrapper.file.lengthSync();
          if (fileWrapper.asset.type == AssetType.image) {
            return fileSize < 50 * 1024 || fileSize > 15 * 1024 * 1024;
          } else if (fileWrapper.asset.type == AssetType.video) {
            return fileSize < 50 * 1024 || fileSize > 20 * 1024 * 1024;
          }
          return false;
        }

        final fileWrappers =
            (await Future.wait(fileWrapperFutures)).whereNotNull().toList();
        final limiter = fileWrappers.firstWhereOrNull(tester);
        if (limiter != null) {
          if (limiter.asset.type == AssetType.image) {
            await EasyLoading.showToast(
              '上传的图片必须在15KB至15MB之间.',
            );
            return;
          } else if (limiter.asset.type == AssetType.video) {
            await EasyLoading.showToast(
              '上传的视频必须在15KB至20MB之间.',
            );
            return;
          }
        }

        setInnerState(() => _fileWrappers = fileWrappers);
      } on RequestedException catch (error, stackTrace) {
        printErrorStackLog(error, stackTrace);
        await EasyLoading.showError(error.msg);
      }
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await EasyLoading.show();
        final files = <Map<String, dynamic>>[];
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
                (fileModel) => {
                  'url': fileModel.url,
                  'type': fileModel.type,
                  'size': fileModel.fileSize,
                  'title': fileModel.oldFileName,
                },
              ),
            );
          }
        }

        final feedback = await FeedbackApi.addFeedback(
          title: _titleController.text,
          description: _descriptionController.text,
          files: files.isEmpty ? null : files,
        );
        await EasyLoading.dismiss();
        if (feedback != null) {
          NavigatorUtil.pop();
          _titleController.clear();
          _descriptionController.clear();
          setState(() => _fileWrappers = []);
          _load();
        }
      } on RequestedException catch (error, stackTrace) {
        printErrorStackLog(error, stackTrace);
        await EasyLoading.showError(error.msg);
      }
    }
  }

  void _onReorder(StateSetter setInnerState, int oldIndex, int newIndex) {
    setInnerState(
      () => _fileWrappers = _fileWrappers..swap(oldIndex, newIndex),
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

    FeedbackApi.getFeedbackList(page: currentPage).then(
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
    ).onError<RequestedException>((error, stackTrace) {
      printErrorStackLog(error, stackTrace);
      if (operation == Operation.none) {
        setState(() => loading = false);
        EasyLoading.showError(error.msg);
      } else if (operation == Operation.refresh) {
        _controller.finishRefresh(IndicatorResult.fail);
      } else if (operation == Operation.load) {
        _controller.finishLoad(IndicatorResult.fail);
      }
    });
  }
}
