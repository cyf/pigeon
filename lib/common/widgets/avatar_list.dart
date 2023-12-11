import 'package:flutter/material.dart';

enum AvatarListLeading {
  tight,
  loose,
  none,
}

class AvatarList extends StatefulWidget {
  const AvatarList({
    required this.avatars,
    this.leading = AvatarListLeading.none,
    this.curve = Curves.easeInOutCubic,
    this.duration = const Duration(milliseconds: 200),
    this.scrollController,
    super.key,
  });

  final List<Widget> avatars;
  final AvatarListLeading leading;
  final Curve curve;
  final Duration duration;
  final ScrollController? scrollController;
  @override
  State<AvatarList> createState() => _AvatarListState();
}

class _AvatarListState extends State<AvatarList> {
  double leading = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthFactor = 1.0;
    switch (widget.leading) {
      case AvatarListLeading.tight:
        widthFactor = 0.6;
      case AvatarListLeading.loose:
        widthFactor = 0.8;
      case AvatarListLeading.none:
        break;
    }

    return ListView.builder(
      controller: widget.scrollController,
      cacheExtent: widget.avatars.length / 2,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.avatars.length,
      itemBuilder: (context, index) {
        return AnimatedAlign(
          widthFactor: widthFactor,
          alignment: Alignment.centerLeft,
          curve: widget.curve,
          duration: widget.duration,
          child: widget.avatars[index],
        );
      },
    );
  }
}

class AvatarListItem extends StatelessWidget {
  const AvatarListItem({
    required this.imageProvider,
    this.radius = 30,
    super.key,
  });

  final double radius;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageProvider,
    );
  }
}
