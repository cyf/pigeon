// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:pigeon/app/navigator.dart';
import 'package:pigeon/common/constants/keys.dart';
import 'package:pigeon/common/extensions/single.dart';
import 'package:pigeon/common/utils/navigator_util.dart';
import 'package:pigeon/common/utils/sp_util.dart';
import 'package:pigeon/common/utils/string_util.dart';
import 'package:pigeon/i18n/i18n.dart';
import 'package:pigeon/theme/colors.dart';

const double _buttonHeight = 54;

class DialogUtil {
  static void showLicenseDialog() {
    final context = AppNavigator.key.currentContext!;
    final isContainsKey = SpUtil.containsKey(Keys.licenseKey) ?? false;

    log('isContainsKey: $isContainsKey');

    /// 未弹出过隐私协议弹窗
    if (!isContainsKey) {
      final t = Translations.of(context);
      final languageCode = LocaleSettings.currentLocale.languageCode;

      final width = MediaQuery.sizeOf(context).width;
      final height = MediaQuery.sizeOf(context).height;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          final androidPermissionTexts = t.dialogs.license.androidPermissions
              .mapIndexed(
                (index, permissionText) => Text(
                  '${index + 1}. $permissionText',
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
              )
              .toList();

          final iosPermissionTexts = t.dialogs.license.iosPermissions
              .mapIndexed(
                (index, permissionText) => Text(
                  '${index + 1}. $permissionText',
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
              )
              .toList();

          return AlertDialog(
            title: Text(
              t.dialogs.license.title,
              style: TextStyle(
                color: isDark ? Colors.white : primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.dialogs.license.contentContent,
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  t.dialogs.license.contentTip,
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
                if (Platform.isAndroid) ...androidPermissionTexts,
                if (Platform.isIOS) ...iosPermissionTexts,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t.dialogs.license.contentPrefix,
                        style: TextStyle(
                          color: isDark ? Colors.white : primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.license.contentUserAgreement,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.parse(
                              'https://www.chenyifaer.com/homing-pigeon/$languageCode/legal/terms-of-use/',
                            );
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.license.contentAnd,
                        style: TextStyle(
                          color: isDark ? Colors.white : primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.license.contentPrivacyAgreement,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.parse(
                              'https://www.chenyifaer.com/homing-pigeon/$languageCode/legal/privacy/',
                            );
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.license.contentSuffix,
                        style: TextStyle(
                          color: isDark ? Colors.white : primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
              ],
            )
                .nestedSingleChildScrollView()
                .nestedConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height * 0.4,
                  ),
                )
                .nestedSizedBox(width: width),
            actions: [
              Row(
                children: [
                  Text(
                    t.buttons.cancel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : secondaryTextColor,
                      fontSize: 16,
                      height: 1.375,
                    ),
                  )
                      .nestedPadding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  )
                      .nestedTap(() {
                    SpUtil.putBool(Keys.licenseKey, value: false);
                    NavigatorUtil.pop();
                    // exit(0);
                  }).nestedExpanded(),
                  Text(
                    t.buttons.agree,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      height: 1.375,
                    ),
                  )
                      .nestedPadding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      )
                      .nestedDecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: borderColor)),
                        ),
                      )
                      .nestedTap(() {
                    SpUtil.putBool(Keys.licenseKey, value: true);
                    NavigatorUtil.pop();
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
            contentPadding: const EdgeInsets.all(20),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      );
    }
  }

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
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.375,
                      ),
                    ),
                    overlayColor: WidgetStateProperty.all(backgroundColor),
                    shape: WidgetStateProperty.all(
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
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.375,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
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
