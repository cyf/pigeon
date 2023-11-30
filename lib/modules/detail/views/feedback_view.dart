import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HpAppBar(
        titleWidget: const Text('Feedback'),
      ),
      body: const Center(
        child: Text('Feedback'),
      ),
    );
  }
}
