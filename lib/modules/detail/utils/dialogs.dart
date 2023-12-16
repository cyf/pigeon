import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:photo_view/photo_view.dart';

class Dialogs {
  static void showGalleryPermissionDialog() {
    showDialog<void>(
      context: AppNavigator.key.currentContext!,
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                  )
                  .nestedTap(NavigatorUtil.pop)
                  .nestedExpanded(),
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                  )
                  .nestedDecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(left: BorderSide(color: borderColor)),
                    ),
                  )
                  .nestedTap(() async {
                NavigatorUtil.pop();
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
