import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/theme/colors.dart';

class Section extends StatelessWidget {
  const Section({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<SectionItem> items;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverStickyHeader(
      header: Text(
        title,
        style: const TextStyle(color: secondaryTextColor, fontSize: 16),
      )
          .nestedPadding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 6),
          )
          .nestedColoredBox(
            color: isDark ? Colors.black87 : secondaryGrayColor,
          ),
      sliver: SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        sliver: DecoratedSliver(
          decoration: BoxDecoration(
            color: isDark ? primaryTextColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => items.elementAt(i),
              childCount: items.length,
            ),
          ),
        ),
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  const SectionItem({
    required this.title,
    this.showBack = true,
    this.showBorder = true,
    this.borderHeight = 1,
    this.height = 68,
    this.tipsColor = placeholderTextColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.contentPadding = const EdgeInsets.only(right: 10),
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 5),
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.tips,
    this.onTap,
    super.key,
  });

  final String title;
  final Color tipsColor;
  final bool showBack;
  final bool showBorder;
  final double borderHeight;
  final double height;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry innerPadding;
  final VoidCallback? onTap;
  final String? tips;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? secondaryGrayColor : primaryTextColor,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (tips != null)
                Text(
                  tips!,
                  style: TextStyle(
                    fontSize: 12,
                    color: tipsColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).nestedPadding(padding: const EdgeInsets.only(top: 6)),
            ],
          ).nestedPadding(padding: contentPadding).nestedExpanded(),
          if (showBack)
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: borderColor,
            ),
        ],
      )
          .nestedPadding(padding: innerPadding)
          .nestedDecoratedBox(
            decoration: BoxDecoration(
              border: showBorder
                  ? Border(
                      bottom: BorderSide(
                        color: isDark ? secondaryTextColor : primaryGrayColor,
                        width: borderHeight,
                      ),
                    )
                  : null,
            ),
          )
          .nestedPadding(padding: outerPadding)
          .nestedSizedBox(height: height),
    );
  }
}
