import 'package:flutter/material.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/i18n/i18n.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: HpAppBar(
        isDark: isDark,
        titleName: t.pages.movie.title,
      ),
      body: Center(
        child: Text(t.pages.movie.title),
      ),
    );
  }
}
