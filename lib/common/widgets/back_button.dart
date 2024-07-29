// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pigeon/common/utils/navigator_util.dart';
import 'package:pigeon/common/widgets/nav_button.dart';
import 'package:pigeon/theme/colors.dart';

class HpBackButton extends StatelessWidget {
  const HpBackButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  void onIconButtonPress(BuildContext context) {
    if (onPressed == null) {
      NavigatorUtil.pop();
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
