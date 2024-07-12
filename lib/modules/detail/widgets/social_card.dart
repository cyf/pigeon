import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pigeon/common/extensions/extensions.dart';
import 'package:pigeon/common/models/models.dart';
import 'package:pigeon/common/utils/color_util.dart';
import 'package:pigeon/common/utils/string_util.dart';
import 'package:pigeon/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({required this.item, super.key});

  final SocialModel item;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasSubtitles = item.subtitles != null && item.subtitles!.isNotEmpty;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${item.title}${hasSubtitles ? ': ' : ''}',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (hasSubtitles)
                ...item.subtitles!.map((subtitle) {
                  return TextSpan(
                    text: subtitle.title,
                    style: TextStyle(
                      color: subtitle.color != null
                          ? ColorUtil.stringToColor(
                              subtitle.color!,
                              isDark ? primaryGrayColor : primaryTextColor,
                            )
                          : isDark
                              ? primaryGrayColor
                              : primaryTextColor,
                      // color: primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
            ],
          ),
          scrollPhysics: const NeverScrollableScrollPhysics(),
        ),
        if (item.tips != null && item.tips!.isNotEmpty)
          Text.rich(
            TextSpan(
              children: item.tips!.map(
                (tip) {
                  Widget child = Text(
                    StringUtil.getValue(tip.text),
                    style: TextStyle(
                      color: tip.color != null
                          ? ColorUtil.stringToColor(tip.color!, primaryColor)
                          : primaryColor,
                      fontSize: 16,
                    ),
                  );
                  if (tip.type == LinkType.link) {
                    child = TextButton(
                      onPressed: () => _launchUri(tip),
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        foregroundColor:
                            WidgetStateProperty.all(primaryColor),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.zero,
                        ),
                        textStyle: WidgetStateProperty.all(
                          const TextStyle(fontSize: 14),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: child,
                    );
                  }
                  return WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: child,
                  );
                },
              ).toList(),
            ),
          ).nestedPadding(
            padding: const EdgeInsets.only(top: 4),
          ),
        if (item.descriptions != null && item.descriptions!.isNotEmpty)
          ...List.generate(
            item.descriptions!.length,
            (int index) {
              final description = item.descriptions!.elementAt(index);
              return [
                if (description.name != null)
                  Text(
                    description.name!,
                    style: TextStyle(
                      color: isDark ? primaryGrayColor : primaryTextColor,
                      fontSize: 18,
                    ),
                  ).nestedPadding(padding: const EdgeInsets.only(top: 16)),
                if (description.links != null && description.links!.isNotEmpty)
                  ...List.generate(
                    description.links!.length,
                    (index) {
                      final link = description.links![index];
                      return (link.type == LinkType.link
                              ? TextButton(
                                  onPressed: () => _launchUri(link),
                                  style: ButtonStyle(
                                    minimumSize:
                                        WidgetStateProperty.all(Size.zero),
                                    foregroundColor:
                                        WidgetStateProperty.all(primaryColor),
                                    padding: WidgetStateProperty.all(
                                      EdgeInsets.zero,
                                    ),
                                    textStyle: WidgetStateProperty.all(
                                      const TextStyle(fontSize: 14),
                                    ),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(link.href?.toString() ?? ''),
                                )
                              : SelectableText.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Text(
                                          StringUtil.getValue(link.text),
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: const Icon(
                                          Icons.copy,
                                          color: primaryColor,
                                          size: 14,
                                        ).nestedPadding(
                                          padding: const EdgeInsets.only(
                                            left: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () => FlutterClipboard.copy(
                                    StringUtil.getValue(link.text),
                                  ).then((value) {
                                    EasyLoading.showSuccess(
                                      'Copied',
                                    );
                                  }),
                                  scrollPhysics:
                                      const NeverScrollableScrollPhysics(),
                                ))
                          .nestedPadding(
                        padding: const EdgeInsets.only(top: 10),
                      );
                    },
                  ),
              ];
            },
          ).reduce((value, element) => value + element),
      ],
    )
        .nestedPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        )
        .nestedCard();
  }

  Future<void> _launchUri(Link link) async {
    if (link.href != null) {
      final uri = Uri.tryParse(link.href!);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }
}
