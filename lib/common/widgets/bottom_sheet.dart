import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/theme/colors.dart';

const double buttonHeight = 64;

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    required this.buttonText,
    required this.callback,
    this.items,
    this.header,
    this.mainAxisSize = MainAxisSize.max,
    this.contentPadding = EdgeInsets.zero,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.margin = EdgeInsets.zero,
    this.constraints = const BoxConstraints(),
    super.key,
  });

  final List<Widget>? items;
  final MainAxisSize mainAxisSize;

  final Widget? header;
  final EdgeInsetsGeometry contentPadding;
  final ScrollPhysics physics;

  final EdgeInsetsGeometry margin;
  final BoxConstraints constraints;

  final String buttonText;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final top = MediaQuery.of(context).padding.top;
    final bottom = MediaQuery.of(context).padding.bottom;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final marginBottom = keyboardHeight > 0 ? keyboardHeight : bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) header!,
        if (items != null && items!.isNotEmpty)
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: mainAxisSize,
                children: items!,
              )
                  .nestedSingleChildScrollView(
                    physics: physics,
                    padding: contentPadding,
                  )
                  .nestedPadding(padding: margin)
                  .nestedColoredBox(
                    color: isDark ? primaryTextColor : Colors.white,
                  )
                  .nestedPadding(
                    padding: EdgeInsets.only(
                      bottom: marginBottom + buttonHeight + 8,
                    ),
                  )
                  .nestedSizedBox(width: width)
                  .nestedConstrainedBox(
                    constraints: constraints.copyWith(
                      maxHeight: keyboardHeight > 0
                          ? (height - top - bottom) * 0.9
                          : constraints.maxHeight,
                    ),
                  ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isDark ? primaryTextColor : Colors.white,
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(),
                    ),
                  ),
                  onPressed: callback,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? Colors.white : primaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                      .nestedCenter()
                      .nestedSizedBox(height: buttonHeight)
                      .nestedPadding(
                        padding: EdgeInsets.only(bottom: marginBottom),
                      ),
                ),
              ),
            ],
          )
        else
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                isDark ? primaryTextColor : Colors.white,
              ),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(),
              ),
            ),
            onPressed: callback,
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : primaryTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
                .nestedCenter()
                .nestedSizedBox(height: buttonHeight)
                .nestedPadding(padding: EdgeInsets.only(bottom: bottom)),
          ),
      ],
    ).nestedSingleChildScrollView();
  }
}
