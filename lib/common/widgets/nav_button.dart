import 'package:flutter/material.dart';
import 'package:pigeon/theme/colors.dart';

class NavButton extends StatelessWidget {
  const NavButton(
    this.icon, {
    required this.onPressed,
    this.scale,
    this.iconSize,
    this.color,
    super.key,
  });

  final VoidCallback onPressed;
  final double? scale;
  final double? iconSize;
  final Color? color;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final finalScale = scale ?? 0.6;
    final finalIconSize = iconSize ?? 30;
    final finalColor = color ?? placeholderTextColor;
    return Transform.scale(
      scale: finalScale,
      child: IconButton(
        iconSize: finalIconSize,
        color: finalColor,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
