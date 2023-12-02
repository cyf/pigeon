import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/theme/colors.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    required this.items,
    this.physics = const NeverScrollableScrollPhysics(),
    this.shrinkWrap = true,
    super.key,
  });

  final List<Widget> items;
  final ScrollPhysics physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: shrinkWrap,
          itemCount: items.length,
          physics: physics,
          itemBuilder: (context, index) => items[index],
        ).nestedPadding(padding: EdgeInsets.only(bottom: bottom + 64 + 16)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: TextButton(
            onPressed: () => NavigatorUtil.pop(context),
            child: const Text(
              '取消',
              style: TextStyle(fontSize: 18, color: primaryTextColor),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
                .nestedCenter()
                .nestedSizedBox(height: 64)
                .nestedPadding(padding: EdgeInsets.only(bottom: bottom)),
          ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
        ),
      ],
    );
  }
}
