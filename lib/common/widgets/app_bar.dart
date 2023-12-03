import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/theme/colors.dart';

class HpAppBar extends AppBar {
  HpAppBar({
    super.key,
    super.actions,
    this.titleName,
    this.titleWidget,
    this.onBackClick,
    this.hideBack = false,
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
              color: borderColor,
              height: 1,
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        );

  final String? titleName;
  final Widget? titleWidget;
  final VoidCallback? onBackClick;
  final bool hideBack;
}
