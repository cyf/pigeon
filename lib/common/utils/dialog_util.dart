import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:photo_view/photo_view.dart';

const double _buttonHeight = 54;

class DialogUtil {
  static void showCustomDialog({
    String? title,
    String? content,
    Widget? titleWidget,
    Widget? contentWidget,
    String cancelText = 'Cancel',
    String okText = 'OK',
    Color cancelColor = secondaryTextColor,
    Color okColor = primaryColor,
    bool hideCancel = false,
    bool barrierDismissible = false,
    VoidCallback? onCancel,
    VoidCallback? onOK,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding,
  }) {
    showDialog<void>(
      context: AppNavigator.key.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => AlertDialog(
        title: titleWidget ??
            (StringUtil.isNotBlank(title)
                ? Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null),
        content: contentWidget ??
            (StringUtil.isNotBlank(content)
                ? Text(
                    content!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : null),
        actions: [
          Row(
            children: [
              if (!hideCancel) ...[
                TextButton(
                  onPressed: onCancel ?? NavigatorUtil.pop,
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.375,
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(backgroundColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: Text(
                    cancelText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: cancelColor,
                    ),
                  ),
                ).nestedSizedBox(height: _buttonHeight - 1).nestedExpanded(),
                const ColoredBox(color: borderColor)
                    .nestedSizedBox(width: 1, height: _buttonHeight),
              ],
              TextButton(
                onPressed: onOK,
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.375,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: Text(
                  okText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: okColor,
                  ),
                ),
              ).nestedSizedBox(height: _buttonHeight - 1).nestedExpanded(),
            ],
          )
              .nestedDecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: borderColor)),
                ),
              )
              .nestedSizedBox(height: _buttonHeight),
        ],
        titlePadding: titlePadding,
        contentPadding: contentPadding,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsOverflowButtonSpacing: 0,
        actionsAlignment: MainAxisAlignment.center,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void showImagePreviewDialog(String id, String url) {
    showDialog<void>(
      context: AppNavigator.key.currentContext!,
      builder: (context) => PhotoView.customChild(
        backgroundDecoration: const BoxDecoration(color: Colors.black45),
        heroAttributes: PhotoViewHeroAttributes(tag: id),
        child: CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(
            color: primaryColor,
          ).nestedSizedBox(width: 30, height: 30).nestedCenter(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: errorTextColor,
            size: 24,
          ),
        ).nestedTap(NavigatorUtil.pop),
      ),
    );
  }
}
