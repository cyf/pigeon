import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/theme/colors.dart';

class Dialogs {
  static void showGalleryPermissionDialog(BuildContext context) {
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
}
