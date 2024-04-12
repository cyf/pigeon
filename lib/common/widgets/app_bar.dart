import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/theme/colors.dart';

class HpAppBar extends AppBar {
  HpAppBar({
    required this.isDark,
    this.titleName,
    this.titleWidget,
    this.onBackClick,
    this.hideBack = false,
    super.key,
    super.actions,
  }) : super(
          leading: hideBack
              ? null
              : HpBackButton(
                  onPressed: onBackClick,
                ),
          title: titleName == null
              ? titleWidget
              : Text(
                  titleName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: isDark ? secondaryTextColor : borderColor,
              height: 1,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDark ? Colors.black : Colors.white,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
        );

  final String? titleName;
  final Widget? titleWidget;
  final VoidCallback? onBackClick;
  final bool hideBack;
  final bool isDark;
}
