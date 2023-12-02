import 'dart:ui';

class ColorUtil {
  static Color? stringToColor(String hexColor) {
    final hexNumber = int.tryParse(
      hexColor.toUpperCase().replaceAll(RegExp('^(#|0X)'), '').padLeft(8, 'F'),
      radix: 16,
    );

    return hexNumber == null ? null : Color(hexNumber);
  }
}
