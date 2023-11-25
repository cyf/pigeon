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

  final Widget title;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: title,
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
    required this.tips,
    required this.backFunc,
    this.showBack = true,
    this.tipsColor = placeholderTextColor,
    super.key,
  });

  final String title;
  final String tips;
  final Color tipsColor;
  final bool showBack;
  final VoidCallback backFunc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: primaryTextColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              tips,
              style: TextStyle(fontSize: 12, color: tipsColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).nestedPadding(padding: const EdgeInsets.only(top: 6)),
          ],
        )
            .nestedPadding(padding: const EdgeInsets.only(right: 10))
            .nestedExpanded(),
        if (showBack)
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: placeholderTextColor,
          ),
      ],
    );
  }
}
