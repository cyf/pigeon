import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/common/api/feedback_api.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/logger/logger.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:reorderables/reorderables.dart';

class FeedbackDetailView extends StatefulWidget {
  const FeedbackDetailView({required this.id, super.key});

  final String id;

  @override
  State<FeedbackDetailView> createState() => _FeedbackDetailViewState();
}

class _FeedbackDetailViewState extends State<FeedbackDetailView> {
  // final _formKey = GlobalKey<FormState>();
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  // bool _isTitleFocus = false;
  // bool _isDescriptionFocus = false;
  //
  // List<FileWrapper> _fileWrappers = [];

  FeedbackModel? _feedback;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // titleFocusNode.addListener(() {
    //   setState(() {
    //     _isTitleFocus = titleFocusNode.hasFocus;
    //   });
    // });
    // descriptionFocusNode.addListener(() {
    //   setState(() {
    //     _isDescriptionFocus = descriptionFocusNode.hasFocus;
    //   });
    // });

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
        titleName: '反馈详情',
      ),
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(),
        onRefresh: () => _load(operation: Operation.refresh),
        child: _buildBody(),
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
    final height = MediaQuery.of(context).size.height;
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;
    if (!_loading && _feedback != null) {
      const spacing = 8.0;
      final width = MediaQuery.of(context).size.width;
      final itemWidth = ((width - spacing * 2) / 3).floorToDouble();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringUtil.getValue(_feedback?.title),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: primaryTextColor,
            ),
          ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
          Text(
            StringUtil.getValue(_feedback?.description),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: secondaryTextColor,
            ),
          ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
          if (_feedback?.files?.isNotEmpty ?? false)
            ReorderableWrap(
              spacing: spacing,
              runSpacing: 4,
              padding: EdgeInsets.zero,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              onReorder: (int oldIndex, int newIndex) => {},
              enableReorder: false,
              children: _feedback!.files!
                  .map(
                    (file) => CachedNetworkImage(
                      imageUrl: StringUtil.getValue(file.url),
                      imageBuilder: (context, imageProvider) => Container(
                        width: itemWidth,
                        height: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: primaryColor,
                      ).nestedSizedBox(width: 30, height: 30).nestedCenter(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: errorTextColor,
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      )
          .nestedPadding(padding: const EdgeInsets.all(10))
          .nestedDecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          )
          .nestedPadding(padding: const EdgeInsets.symmetric(vertical: 10))
          .nestedConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height - top - kToolbarHeight - bottom,
            ),
          )
          .nestedSingleChildScrollView();
    }

    if (!_loading && _feedback == null) {
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
      )
          .nestedSizedBox(height: height - top - kToolbarHeight - bottom)
          .nestedSingleChildScrollView();
    }

    return const SizedBox();
  }

  void _load({Operation operation = Operation.none}) {
    if (operation == Operation.none) {
      setState(() => _loading = true);
      EasyLoading.show();
    }

    FeedbackApi.getFeedbackDetail(id: widget.id).then(
      (data) {
        if (operation == Operation.none) {
          EasyLoading.dismiss();
          setState(() {
            _loading = false;
            _feedback = data;
          });
        } else if (operation == Operation.refresh) {
          _controller.finishRefresh();
          setState(() => _feedback = data);
        }
      },
    ).onError<RequestedException>((error, stackTrace) {
      printErrorStackLog(error, stackTrace);
      if (operation == Operation.none) {
        setState(() => _loading = false);
        EasyLoading.showError(error.msg);
      } else if (operation == Operation.refresh) {
        _controller.finishRefresh(IndicatorResult.fail);
      }
    });
  }

  // void showUploadBottomSheet() {
  //   const spacing = 8.0;
  //   const padding = 10.0;
  //   final width = MediaQuery.of(context).size.width - padding * 2;
  //   final itemWidth = ((width - spacing * 2) / 3).floorToDouble();
  //
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) => StatefulBuilder(
  //       builder: (BuildContext context, StateSetter setInnerState) {
  //         final items = _fileWrappers
  //             .mapIndexed(
  //               (index, element) {
  //                 if (kDebugMode) {
  //                   print(element.file.path);
  //                 }
  //                 return Stack(
  //                   children: [
  //                     Image.file(
  //                       element.file,
  //                       fit: BoxFit.cover,
  //                       errorBuilder: (context, url, error) => const Icon(
  //                         Icons.error,
  //                         color: errorTextColor,
  //                         size: 24,
  //                       ),
  //                     ).nestedSizedBox(width: itemWidth, height: itemWidth),
  //                     Positioned(
  //                       top: 2,
  //                       right: 2,
  //                       child: const Icon(
  //                         Icons.clear,
  //                         color: warnTextColor,
  //                         size: 14,
  //                       )
  //                           .nestedDecoratedBox(
  //                             decoration: BoxDecoration(
  //                               color: backgroundColor,
  //                               borderRadius: BorderRadius.circular(9),
  //                             ),
  //                           )
  //                           .nestedSizedBox(width: 18, height: 18)
  //                           .nestedTap(
  //                             () => setInnerState(
  //                               () => _fileWrappers = _fileWrappers
  //                                 ..removeAt(index),
  //                             ),
  //                           ),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             )
  //             .cast<Widget>()
  //             .toList();
  //
  //         if (items.length < 9) {
  //           items.add(
  //             const Icon(
  //               Icons.add,
  //               size: 40,
  //               color: primaryColor,
  //             )
  //                 .nestedCenter()
  //                 .nestedColoredBox(color: secondaryGrayColor)
  //                 .nestedSizedBox(width: itemWidth, height: itemWidth)
  //                 .nestedInkWell(onTap: () => _pickImages(setInnerState)),
  //           );
  //         }
  //
  //         return KeyboardDismisser(
  //           child: ModalBottomSheet(
  //             shrinkWrap: false,
  //             physics: const AlwaysScrollableScrollPhysics(),
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             margin: const EdgeInsets.symmetric(vertical: 10),
  //             callback: _submit,
  //             button: '提交',
  //             items: [
  //               Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   children: [
  //                     BaseFormItem(
  //                       title: '标题',
  //                       showTip: false,
  //                       padding: EdgeInsets.zero,
  //                       child: TextFormField(
  //                         focusNode: titleFocusNode,
  //                         controller: _titleController,
  //                         cursorColor: primaryColor,
  //                         autocorrect: false,
  //                         onChanged: (value) {
  //                           setInnerState(() {});
  //                         },
  //                         maxLines: 3,
  //                         maxLength: 100,
  //                         decoration: InputDecoration(
  //                           suffixIcon: (_isTitleFocus &&
  //                                   _titleController.text.isNotEmpty)
  //                               ? Container(
  //                                   width: 20,
  //                                   height: 20,
  //                                   margin: const EdgeInsets.only(right: 10),
  //                                   decoration: BoxDecoration(
  //                                     color: primaryGrayColor,
  //                                     borderRadius: BorderRadius.circular(15),
  //                                   ),
  //                                   child: IconButton(
  //                                     padding: EdgeInsets.zero,
  //                                     splashRadius: 2,
  //                                     onPressed: () {
  //                                       // Clear everything in the text field
  //                                       _titleController.clear();
  //                                       // Call setState to update the UI
  //                                       setInnerState(() {});
  //                                     },
  //                                     iconSize: 16,
  //                                     icon: const Icon(
  //                                       Icons.clear,
  //                                       color: placeholderTextColor,
  //                                     ),
  //                                   ),
  //                                 )
  //                               : null,
  //                           suffixIconConstraints: const BoxConstraints(
  //                             maxWidth: 30,
  //                             maxHeight: 30,
  //                           ),
  //                           hintText: '请输入标题',
  //                           contentPadding: const EdgeInsets.all(8),
  //                           fillColor: secondaryGrayColor,
  //                           filled: true,
  //                         ),
  //                         validator: (value) {
  //                           if (StringUtil.isBlank(value)) {
  //                             return '请输入标题';
  //                           }
  //                           return null;
  //                         },
  //                       ).nestedPadding(
  //                         padding: const EdgeInsets.only(top: 8),
  //                       ),
  //                     ),
  //                     BaseFormItem(
  //                       title: '描述',
  //                       showTip: false,
  //                       child: TextFormField(
  //                         focusNode: descriptionFocusNode,
  //                         controller: _descriptionController,
  //                         cursorColor: primaryColor,
  //                         autocorrect: false,
  //                         onChanged: (value) {
  //                           setInnerState(() {});
  //                         },
  //                         maxLines: 10,
  //                         maxLength: 500,
  //                         decoration: InputDecoration(
  //                           suffixIcon: (_isDescriptionFocus &&
  //                                   _descriptionController.text.isNotEmpty)
  //                               ? Container(
  //                                   width: 20,
  //                                   height: 20,
  //                                   margin: const EdgeInsets.only(right: 10),
  //                                   decoration: BoxDecoration(
  //                                     color: primaryGrayColor,
  //                                     borderRadius: BorderRadius.circular(15),
  //                                   ),
  //                                   child: IconButton(
  //                                     padding: EdgeInsets.zero,
  //                                     splashRadius: 2,
  //                                     onPressed: () {
  //                                       // Clear everything in the text field
  //                                       _descriptionController.clear();
  //                                       // Call setState to update the UI
  //                                       setInnerState(() {});
  //                                     },
  //                                     iconSize: 16,
  //                                     icon: const Icon(
  //                                       Icons.clear,
  //                                       color: placeholderTextColor,
  //                                     ),
  //                                   ),
  //                                 )
  //                               : null,
  //                           suffixIconConstraints: const BoxConstraints(
  //                             maxWidth: 30,
  //                             maxHeight: 30,
  //                           ),
  //                           hintText: '请输入描述',
  //                           contentPadding: const EdgeInsets.all(8),
  //                           fillColor: secondaryGrayColor,
  //                           filled: true,
  //                         ),
  //                         validator: (value) {
  //                           if (StringUtil.isBlank(value)) {
  //                             return '请输入描述';
  //                           }
  //                           return null;
  //                         },
  //                       ).nestedPadding(
  //                         padding: const EdgeInsets.only(top: 8),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               ReorderableWrap(
  //                 spacing: spacing,
  //                 runSpacing: 4,
  //                 onReorder: (int oldIndex, int newIndex) =>
  //                     _onReorder(setInnerState, oldIndex, newIndex),
  //                 children: items,
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // Future<void> _pickImages(StateSetter setInnerState) async {
  //   Map<Permission, PermissionStatus> statuses;
  //   if (defaultTargetPlatform == TargetPlatform.android) {
  //     final deviceInfo = DeviceInfoPlugin();
  //     final androidInfo = await deviceInfo.androidInfo;
  //     if (androidInfo.version.sdkInt >= 33) {
  //       statuses = await [Permission.photos, Permission.videos].request();
  //     } else {
  //       statuses = await [Permission.storage].request();
  //     }
  //   } else {
  //     statuses = await [Permission.photos].request();
  //   }
  //
  //   if (kDebugMode) {
  //     print('statuses: $statuses');
  //   }
  //
  //   final statusList = statuses.values.toList();
  //   final denied = statusList.every(
  //     (status) => [PermissionStatus.permanentlyDenied, PermissionStatus.denied]
  //         .contains(status),
  //   );
  //   if (denied) {
  //     Dialogs.showGalleryPermissionDialog();
  //     return;
  //   }
  //
  //   await _gotoPickImages(setInnerState);
  // }
  //
  // Future<void> _gotoPickImages(StateSetter setInnerState) async {
  //   final assets = await AssetPicker.pickAssets(
  //     context,
  //     pickerConfig: AssetPickerConfig(
  //       selectedAssets:
  //           _fileWrappers.map((fileWrapper) => fileWrapper.asset).toList(),
  //     ),
  //   );
  //   if (assets != null && assets.isNotEmpty) {
  //     try {
  //       final fileWrapperFutures = assets.map((asset) async {
  //         final file = await asset.originFile;
  //         final name = await asset.titleAsync;
  //         return file != null
  //             ? FileWrapper(asset: asset, file: file, name: name)
  //             : null;
  //       }).toList();
  //
  //       final fileWrappers =
  //           (await Future.wait(fileWrapperFutures)).whereNotNull().toList();
  //       final limiter = fileWrappers.firstWhereOrNull(
  //         (fileWrapper) {
  //           final fileSize = fileWrapper.file.lengthSync();
  //           return fileSize < 50 * 1024 || fileSize > 20 * 1024 * 1024;
  //         },
  //       );
  //       if (limiter != null) {
  //         await EasyLoading.showToast(
  //           'The uploaded images or videos must be between 50KB and 20MB.',
  //         );
  //         return;
  //       }
  //
  //       setInnerState(() => _fileWrappers = fileWrappers);
  //     } on RequestedException catch (error, stackTrace) {
  //       printErrorStackLog(error, stackTrace);
  //       await EasyLoading.showError(error.msg);
  //     }
  //   }
  // }
  //
  // Future<void> _submit() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     try {
  //       await EasyLoading.show();
  //       final files = <Map<String, dynamic>>[];
  //       if (_fileWrappers.isNotEmpty) {
  //         final uploadFileFutures = _fileWrappers
  //             .map(
  //               (fileWrapper) async =>
  //                   UploadUtil.upload(fileWrapper: fileWrapper),
  //             )
  //             .toList();
  //         final fileModels = (await Future.wait(uploadFileFutures)).whereNotNull().toList();
  //         if (fileModels.isNotEmpty) {
  //           files.addAll(
  //             fileModels.map(
  //               (fileModel) => {
  //                 'url': fileModel.url,
  //                 'type': fileModel.type,
  //                 'size': fileModel.fileSize,
  //                 'title': fileModel.oldFileName,
  //               },
  //             ),
  //           );
  //         }
  //       }
  //
  //       final feedback = await FeedbackApi.addFeedback(
  //         title: _titleController.text,
  //         description: _descriptionController.text,
  //         files: files.isEmpty ? null : files,
  //       );
  //       await EasyLoading.dismiss();
  //       if (feedback != null) {
  //         NavigatorUtil.pop();
  //         _titleController.clear();
  //         _descriptionController.clear();
  //         setState(() => _fileWrappers = []);
  //         _load();
  //       }
  //     } on RequestedException catch (error, stackTrace) {
  //       printErrorStackLog(error, stackTrace);
  //       await EasyLoading.showError(error.msg);
  //     }
  //   }
  // }
  //
  // void _onReorder(StateSetter setInnerState, int oldIndex, int newIndex) {
  //   setInnerState(
  //     () => _fileWrappers = _fileWrappers..swap(oldIndex, newIndex),
  //   );
  // }
}
