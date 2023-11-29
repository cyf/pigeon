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
    return SliverStickyHeader(
      header: Text(
        title,
        style: const TextStyle(color: secondaryTextColor, fontSize: 16),
      )
          .nestedPadding(
            padding: const EdgeInsets.only(top: 20, left: 10, bottom: 6),
          )
          .nestedColoredBox(color: secondaryGrayColor),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => items.elementAt(i),
          childCount: items.length,
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
    this.bottomBorderColor = primaryGrayColor,
    this.height = 68,
    this.tipsColor = placeholderTextColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.contentPadding = const EdgeInsets.only(right: 10),
    this.outerPadding = const EdgeInsets.only(left: 10, right: 4),
    this.innerPadding = const EdgeInsets.only(left: 10, right: 20),
    this.tips,
    this.onTap,
    super.key,
  });

  final String title;
  final Color tipsColor;
  final bool showBack;
  final bool showBorder;
  final double borderHeight;
  final Color bottomBorderColor;
  final double height;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry innerPadding;
  final VoidCallback? onTap;
  final String? tips;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
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
                style: const TextStyle(fontSize: 18, color: primaryTextColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (tips != null)
                Text(
                  tips!,
                  style: TextStyle(fontSize: 12, color: tipsColor),
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
                        color: bottomBorderColor,
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
