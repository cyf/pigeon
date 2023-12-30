import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/theme/colors.dart';

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
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: primaryTextColor,
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
              padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
              backgroundColor: MaterialStateProperty.all(secondaryGrayColor),
              minimumSize: MaterialStateProperty.all(const Size(24, 24)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: NavigatorUtil.pop,
            icon: const Icon(
              Icons.clear,
              color: borderColor,
              size: 16,
            ),
          ).nestedPadding(padding: const EdgeInsets.only(right: 10)),
      ],
    )
        .nestedPadding(
          padding: const EdgeInsets.symmetric(vertical: 6),
        )
        .nestedDecoratedBox(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryGrayColor,
              ),
            ),
          ),
        )
        .nestedDecoratedBox(
          decoration: const BoxDecoration(color: Colors.white),
        )
        .nestedSizedBox(width: width)
        .nestedConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
        );
  }
}
