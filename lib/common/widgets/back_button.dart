import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/widgets/nav_button.dart';
import 'package:homing_pigeon/theme/colors.dart';

class HpBackButton extends StatelessWidget {
  const HpBackButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  void onIconButtonPress(BuildContext context) {
    if (onPressed == null) {
      NavigatorUtil.pop(context);
    } else {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavButton(
      const Icon(
        Icons.arrow_back_ios_new,
        color: secondaryTextColor,
      ),
      onPressed: () => onIconButtonPress(context),
    );
  }
}
