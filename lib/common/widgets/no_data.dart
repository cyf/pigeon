import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';

class NoData extends StatelessWidget {
  const NoData({
    required this.icon,
    this.title,
    this.content,
    super.key,
  });

  final Widget icon;
  final Widget? title;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        if (title != null) title!,
        if (content != null) content!,
      ],
    ).nestedCenter();
  }
}
