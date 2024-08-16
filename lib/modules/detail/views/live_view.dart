// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:pigeon/app/navigator.dart';
import 'package:pigeon/common/enums/enums.dart';
import 'package:pigeon/common/extensions/single.dart';
import 'package:pigeon/common/http/utils/handle_errors.dart';
import 'package:pigeon/common/widgets/widgets.dart';
import 'package:pigeon/i18n/i18n.dart';

class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  final EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  int totalResults = 0;

  @override
  void initState() {
    super.initState();
    // _load();
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final bottom = MediaQuery.paddingOf(context).bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: HpAppBar(
        isDark: isDark,
        titleName: t.pages.live.title,
      ),
      body: EasyRefresh(
        controller: _easyRefreshController,
        header: const ClassicHeader(),
        // onRefresh: () => _load(operation: Operation.refresh),
        // onLoad: () => _load(operation: Operation.load),
        child: ListView(
          children: [
            // some widgets
            const Text('Live'),
            //some other widgets
            if (kDebugMode) ...[
              const Gap(10),
              ElevatedButton(
                onPressed: _load,
                child: Text(t.buttons.login),
              ),
            ],
          ],
        ),
      ).nestedPadding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10 + bottom,
        ),
      ),
    );
  }

  Future<void> _load({
    Operation operation = Operation.none,
  }) async {
    try {} on Exception catch (error, stackTrace) {
      final context = AppNavigator.key.currentContext!;
      final t = Translations.of(context);
      ErrorHandler.handle(
        error,
        stackTrace: stackTrace,
        postProcessor: (_, msg) {
          if (operation == Operation.none) {
            EasyLoading.showError(msg ?? t.common.failure);
          } else if (operation == Operation.refresh) {
            _easyRefreshController.finishRefresh(IndicatorResult.fail);
          } else if (operation == Operation.load) {
            _easyRefreshController.finishLoad(IndicatorResult.fail);
          }
        },
      );
    }
  }
}
