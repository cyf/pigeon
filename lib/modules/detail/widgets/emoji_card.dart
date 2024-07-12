import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pigeon/common/extensions/extensions.dart';
import 'package:pigeon/common/models/models.dart';
import 'package:pigeon/common/utils/color_util.dart';
import 'package:pigeon/common/utils/dialog_util.dart';
import 'package:pigeon/common/utils/string_util.dart';
import 'package:pigeon/theme/colors.dart';

class EmojiCard extends StatelessWidget {
  const EmojiCard({
    required this.emojis,
    required this.page,
    super.key,
  });

  final List<EmojiModel> emojis;
  final int page;

  @override
  Widget build(BuildContext context) {
    final emoji = emojis.elementAt(page);
    final child = CachedNetworkImage(
      imageUrl: emoji.image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(
        color: primaryColor,
      ).nestedSizedBox(width: 30, height: 30).nestedCenter(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: errorTextColor,
      ),
    );
    return Column(
      children: [
        child.nestedSizedBox(height: 160).nestedTap(
              () => DialogUtil.showImagePreviewDialog(
                StringUtil.getValue(emoji.id),
                emoji.image,
              ),
            ),
        if (StringUtil.isNotBlank(emoji.text))
          Text(
            emoji.text!,
            style: TextStyle(
              fontSize: 14,
              color: StringUtil.isNotBlank(emoji.color)
                  ? ColorUtil.stringToColor(emoji.color!, primaryTextColor)
                  : primaryTextColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
