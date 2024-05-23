import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:homing_pigeon/app/navigator.dart';
import 'package:homing_pigeon/common/enums/enums.dart';
import 'package:homing_pigeon/common/extensions/single.dart';
import 'package:homing_pigeon/common/http/utils/handle_errors.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/common/widgets/widgets.dart';
import 'package:homing_pigeon/i18n/i18n.dart';
import 'package:homing_pigeon/theme/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late YoutubePlayerController _youtubePlayerController;

  PlayerState? _playerState;
  YoutubeMetaData? _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  int currentPage = 1;
  int totalResults = 0;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    )..addListener(listener);

    // _load();
  }

  @override
  void deactivate() {
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final bottom = MediaQuery.of(context).padding.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
        ]);
      },
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      player: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: primaryColor,
        progressColors: const ProgressBarColors(
          playedColor: primaryColor,
          handleColor: primaryHoverColor,
        ),
        onReady: () {
          setState(() => _isPlayerReady = true);
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: HpAppBar(
            isDark: isDark,
            titleName: StringUtil.getValue(
              _videoMetaData?.title,
              defaultVal: t.pages.live.title,
            ),
          ),
          body: EasyRefresh(
            controller: _easyRefreshController,
            header: const ClassicHeader(),
            // onRefresh: () => _load(operation: Operation.refresh),
            // onLoad: () => _load(operation: Operation.load),
            child: ListView(
              children: [
                // some widgets
                player,
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
              bottom: bottom,
            ),
          ),
        );
      },
    );
  }

  void listener() {
    if (_isPlayerReady &&
        mounted &&
        !_youtubePlayerController.value.isFullScreen) {
      setState(() {
        _playerState = _youtubePlayerController.value.playerState;
        _videoMetaData = _youtubePlayerController.metadata;
      });
    }
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
