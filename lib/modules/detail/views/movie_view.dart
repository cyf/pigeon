import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: HpAppBar(
        isDark: isDark,
        titleName: 'Movie',
      ),
      body: const Center(
        child: Text('Movie'),
      ),
    );
  }
}
