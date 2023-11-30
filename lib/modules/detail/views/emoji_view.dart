import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';

class EmojiView extends StatefulWidget {
  const EmojiView({super.key});

  @override
  State<EmojiView> createState() => _EmojiViewState();
}

class _EmojiViewState extends State<EmojiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HpAppBar(
        titleWidget: const Text('Emoji'),
      ),
      body: const Center(
        child: Text('Emoji'),
      ),
    );
  }
}