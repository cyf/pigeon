import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/color_util.dart';
import 'package:homing_pigeon/common/utils/navigator_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:photo_view/photo_view.dart';

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
        child
            .nestedSizedBox(height: 160)
            .nestedTap(() => showImagePreviewDialog(context)),
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

  void showImagePreviewDialog(BuildContext context) {
    final emoji = emojis.elementAt(page);
    showDialog<void>(
      context: context,
      builder: (context) => PhotoView.customChild(
        backgroundDecoration: const BoxDecoration(color: Colors.black45),
        heroAttributes: PhotoViewHeroAttributes(tag: emoji.id ?? ''),
        child: CachedNetworkImage(
          imageUrl: emoji.image,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(
            color: primaryColor,
          ).nestedSizedBox(width: 30, height: 30).nestedCenter(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: errorTextColor,
            size: 24,
          ),
        ).nestedTap(NavigatorUtil.pop),
      ),
    );
  }
}
