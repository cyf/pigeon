import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({required this.item, super.key});

  final CardItem item;

  @override
  Widget build(BuildContext context) {
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
                          ? Color(subtitle.color!)
                          : primaryTextColor,
                      // color: primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
            ],
          ),
        ),
        if (item.tips != null && item.tips!.isNotEmpty)
          Text.rich(
            TextSpan(
              children: item.tips!.map(
                (tip) {
                  Widget child = Text(
                    tip.text,
                    style: TextStyle(
                      color:
                          tip.color != null ? Color(tip.color!) : primaryColor,
                      fontSize: 16,
                    ),
                  );
                  if (tip.type == LinkType.link) {
                    child = TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        foregroundColor:
                            MaterialStateProperty.all(primaryColor),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.zero,
                        ),
                        textStyle: MaterialStateProperty.all(
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
                    '${description.name}',
                    style:
                        const TextStyle(color: primaryTextColor, fontSize: 18),
                  ).nestedPadding(padding: const EdgeInsets.only(top: 16)),
                if (description.links.isNotEmpty)
                  ...List.generate(
                    description.links.length,
                    (index) {
                      final link = description.links[index];
                      return (link.type == LinkType.link
                              ? TextButton(
                                  onPressed: () async {
                                    if (link.uri != null &&
                                        await canLaunchUrl(link.uri!)) {
                                      await launchUrl(link.uri!);
                                    }
                                  },
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all(Size.zero),
                                    foregroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.zero,
                                    ),
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(fontSize: 14),
                                    ),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(link.uri?.toString() ?? ''),
                                )
                              : SelectableText.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: link.text ?? '',
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: const Icon(
                                          Icons.copy,
                                          color: primaryColor,
                                          size: 14,
                                        )
                                            .nestedTap(
                                              () =>
                                                  FlutterClipboard.copy('text')
                                                      .then((value) {
                                                EasyLoading.showSuccess(
                                                  'Copied',
                                                );
                                              }),
                                            )
                                            .nestedPadding(
                                              padding: const EdgeInsets.only(
                                                left: 2,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
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
}
