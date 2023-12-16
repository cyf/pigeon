import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/gen/assets.gen.dart';
import 'package:homing_pigeon/theme/colors.dart';

typedef BaseFormItemCallback = void Function();

class BaseFormItem extends StatelessWidget {
  const BaseFormItem({
    required this.title,
    required this.child,
    this.required = true,
    this.showTip = true,
    this.padding = const EdgeInsets.only(top: 10),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.tipWidget,
    this.onTipTap,
    super.key,
  });

  final String title;
  final Widget child;
  final bool required;
  final bool showTip;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? tipWidget;
  final BaseFormItemCallback? onTipTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!showTip)
          content
        else
          content
              .addWidgetAsList(
                tipWidget == null
                    ? tips
                    : tipWidget!.nestedTap(() {
                        onTipTap?.call();
                      }),
              )
              .nestedRow(mainAxisAlignment: mainAxisAlignment),
        child,
      ],
    ).nestedPadding(padding: padding);
  }

  Widget get content {
    return RichText(
      text: TextSpan(
        children: [
          if (required)
            const TextSpan(
              text: '*',
              style: TextStyle(
                color: errorTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          TextSpan(
            text: title,
            style: const TextStyle(
              color: primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget get tips {
    return Assets.info
        .image(height: 16, width: 16)
        .nestedPadding(
          padding: const EdgeInsets.only(left: 4),
        )
        .nestedTap(() {
      onTipTap?.call();
    });
  }
}
