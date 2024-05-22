import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/dialog_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedbackCard extends StatefulWidget {
  const FeedbackCard({required this.feedback, super.key});

  final FeedbackModel feedback;

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final files = widget.feedback.files ?? <FeedbackFileModel>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringUtil.getValue(widget.feedback.title),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : primaryTextColor,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
        Text(
          StringUtil.getValue(widget.feedback.description),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? primaryGrayColor : secondaryTextColor,
          ),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
        if (files.isNotEmpty)
          StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: files
                .where((file) => file.type?.startsWith('image/') ?? false)
                .map(
              (file) {
                final width = MediaQuery.sizeOf(context).width - 10 * 2;
                final itemWidth = ((width - 5 * 2) / 3).floorToDouble();
                // TODO(kjxbyz): add video preview.
                return CachedNetworkImage(
                  imageUrl: StringUtil.getValue(file.url),
                  imageBuilder: (context, imageProvider) => Container(
                    width: itemWidth,
                    height: itemWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).nestedTap(
                    () => DialogUtil.showImagePreviewDialog(
                      StringUtil.getValue(file.id),
                      StringUtil.getValue(file.url),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: primaryColor,
                  ).nestedSizedBox(width: 30, height: 30).nestedCenter(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: errorTextColor,
                  ),
                );
              },
            ).toList(),
          ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'datadatadatadatadatadatadatadatadata',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? primaryGrayColor : secondaryTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).nestedFlexible(),
            if (widget.feedback.createDate != null)
              Text(
                timeago.format(widget.feedback.createDate!),
                style: const TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ],
    ).nestedPadding(padding: const EdgeInsets.all(10)).nestedDecoratedBox(
          decoration: BoxDecoration(
            color: isDark ? primaryTextColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        );
  }
}
