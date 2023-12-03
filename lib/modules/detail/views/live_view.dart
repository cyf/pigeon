import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';

class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HpAppBar(
        titleName: 'Live',
      ),
      body: const Center(
        child: Text('Live'),
      ),
    );
  }
}
