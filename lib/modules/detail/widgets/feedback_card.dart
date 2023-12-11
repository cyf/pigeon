// import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
// import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/theme/colors.dart';

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
    // final files = widget.feedback.files ?? <FeedbackFileModel>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringUtil.getValue(widget.feedback.title),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
        Text(
          StringUtil.getValue(widget.feedback.description),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: secondaryTextColor,
          ),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ).nestedPadding(padding: const EdgeInsets.only(bottom: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'datadatadatadatadatadatadatadatadata',
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).nestedFlexible(),
            const Text(
              '2023-12-08 12:12:12',
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        // if (files.isNotEmpty) avatarList,
      ],
    ).nestedPadding(padding: const EdgeInsets.all(10)).nestedDecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        );
  }

  // Widget get avatarList {
  //   final originFiles = widget.feedback.files ?? <FeedbackFileModel>[];
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           expanded = !expanded;
  //         });
  //       },
  //       child: AvatarList(
  //         leading:
  //         expanded ? AvatarListLeading.none : AvatarListLeading.tight,
  //         avatars: (expanded ? originFiles : originFiles.slice(0, 1))
  //             .map(
  //               (file) => generateAvatarListItem(
  //             StringUtil.getValue(file.url),
  //           ),
  //         )
  //             .toList(),
  //       ).nestedSizedBox(height: 60).nestedPadding(
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget generateAvatarListItem(String url) {
  //   return AvatarListItem(
  //     imageProvider: NetworkImage(url),
  //   ).nestedPadding(padding: const EdgeInsets.only(right: 6));
  // }
}
