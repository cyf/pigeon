import 'package:flutter/material.dart';
import 'package:pigeon/common/extensions/single.dart';
import 'package:pigeon/common/utils/navigator_util.dart';
import 'package:pigeon/theme/colors.dart';

class HpHeader extends StatelessWidget {
  const HpHeader({
    required this.title,
    this.hideCancel = false,
    super.key,
  });

  final String title;
  final bool hideCancel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white : primaryTextColor,
          ),
          maxLines: 1,
          textAlign: hideCancel ? TextAlign.center : TextAlign.start,
          overflow: TextOverflow.ellipsis,
        )
            .nestedPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
            )
            .nestedExpanded(),
        if (!hideCancel)
          IconButton.outlined(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                const EdgeInsets.all(5),
              ),
              side: WidgetStateProperty.all(BorderSide.none),
              backgroundColor: WidgetStateProperty.all(
                isDark ? borderColor : secondaryGrayColor,
              ),
              elevation: WidgetStateProperty.all(0),
              minimumSize: WidgetStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: NavigatorUtil.pop,
            icon: Icon(
              Icons.clear,
              color: isDark ? secondaryTextColor : borderColor,
              size: 16,
            ),
          ).nestedPadding(padding: const EdgeInsets.only(right: 10)),
      ],
    )
        .nestedPadding(
          padding: const EdgeInsets.symmetric(vertical: 6),
        )
        .nestedDecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDark ? secondaryTextColor : primaryGrayColor,
              ),
            ),
          ),
        )
        .nestedDecoratedBox(
          decoration: BoxDecoration(
            color: isDark ? primaryTextColor : Colors.white,
          ),
        )
        .nestedSizedBox(width: width)
        .nestedConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
        );
  }
}
