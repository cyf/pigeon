import 'package:flutter/material.dart' hide Navigator;
import 'package:flutter/scheduler.dart';
import 'package:homing_pigeon/common/extensions/extensions.dart';
import 'package:homing_pigeon/common/http/constants/code.dart';
import 'package:homing_pigeon/common/http/event/http_error_event.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:homing_pigeon/theme/colors.dart';

class HttpErrorBoundary {
  factory HttpErrorBoundary() => _instance;

  HttpErrorBoundary._internal();

  Widget? _w;
  ErrorBoundaryOverlayEntry? overlayEntry;

  Widget? get w => _w;
  GlobalKey<NetworkErrorAlertContainerState>? _key;

  GlobalKey<NetworkErrorAlertContainerState>? get key => _key;
  static final HttpErrorBoundary _instance = HttpErrorBoundary._internal();
  static final Map<String, bool> _cacheMap = <String, bool>{};

  static HttpErrorBoundary get instance => _instance;

  static bool get isShow => _instance.w != null;

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, _ErrorBoundary(child: child));
      } else {
        return _ErrorBoundary(child: child);
      }
    };
  }

  static Future<void> handleErrorEvent(HttpErrorEvent event) async {
    if (StringUtil.isNotBlank(event.code) && !_cacheMap.containsKey(event.code)) {
      _cacheMap[event.code!] = true;
      switch (event.code) {
        case Code.networkError:
          _noNetworkHandler();
        case Code.networkUnAuthorized:
        case Code.networkUnAccess:
          _unAuthorizedHandler(event.code!);
        default:
          Future.delayed(const Duration(seconds: 2), () {
            _cacheMap.remove(event.code);
          });
        // _errorDefaultHandler(event);
      }
    }
  }

  static void _noNetworkHandler() {
    instance._show(
      title: 'Tips',
      content: 'Network error. Please check your network and restart the app.',
      onConfirm: () {
        _cacheMap.remove(Code.networkError);
      },
    );
  }

  static void _unAuthorizedHandler(String code) {
    // Future.delayed(const Duration(seconds: 2), () {
    //   _cacheMap.remove(Code.networkUnAuthorized);
    //   Future.microtask(() async {
    //     final notificationKeyValue = SpUtil.getString(Keys.notificationKey);
    //     await SpUtil.clear();
    //     await SpUtil.putString(Keys.licenseKey, Keys.licenseKey);
    //     if (StringUtil.isNotBlank(notificationKeyValue)) {
    //       await SpUtil.putString(Keys.notificationKey, Keys.notificationKey);
    //     }
    //     await deleteAlias(0);
    //   }).whenComplete(() {
    //     NavigatorUtil.pushAndRemoveUntil(
    //       navigatorKey.currentContext!,
    //       const LoginPage(),
    //           (Route<dynamic> route) => false,
    //     );
    //   });
    // });
    instance._show(
      title: 'Tips',
      content: 'Login expired. Please log in again.',
      onConfirm: () {
        _cacheMap.remove(code);
        // TODO(kjxbyz): logout
      },
    );
  }

  // static void _errorDefaultHandler(HttpErrorEvent event) {
  //   Fluttertoast.showToast(
  //     msg: 'Error Code: ${event.code}\nError Message: ${event.message}',
  //   ).whenComplete(() => _cacheMap.remove(event.code));
  // }

  Future<void> _show({
    required String title,
    required String content,
    VoidCallback? onConfirm,
  }) async {
    _key = GlobalKey<NetworkErrorAlertContainerState>();
    _w = NetworkErrorAlertContainer(
      title: title,
      content: content,
      onConfirm: onConfirm,
    );
    _markNeedsBuild();
  }

  Future<void> _dismiss() async {
    _w = null;
    _key = null;
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }
}

class _ErrorBoundary extends StatefulWidget {
  const _ErrorBoundary({this.child});

  final Widget? child;

  @override
  State<_ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<_ErrorBoundary> {
  late ErrorBoundaryOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = ErrorBoundaryOverlayEntry(
      builder: (BuildContext context) =>
          HttpErrorBoundary.instance.w ?? Container(),
    );
    HttpErrorBoundary.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          ErrorBoundaryOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}

class ErrorBoundaryOverlayEntry extends OverlayEntry {
  ErrorBoundaryOverlayEntry({
    required this.builder,
  }) : super(builder: builder);
  @override
  // ignore: overridden_fields
  final WidgetBuilder builder;

  @override
  void markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}

class NetworkErrorAlertContainer extends StatefulWidget {
  const NetworkErrorAlertContainer({
    required this.title,
    required this.content,
    this.onConfirm,
    super.key,
  });

  final String title;
  final String content;
  final VoidCallback? onConfirm;

  @override
  State<NetworkErrorAlertContainer> createState() =>
      NetworkErrorAlertContainerState();
}

class NetworkErrorAlertContainerState
    extends State<NetworkErrorAlertContainer> {
  /// 处理点击按钮背景颜色
  /// 设置当前按钮为不可点击时，设置onPressed回调为null。
  WidgetStateProperty<Color> createTextBtnBgColor() {
    return WidgetStateProperty.resolveWith((states) {
      return primaryColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: FittedBox(
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/network_error.png',
                  width: 114,
                  height: 114,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tips',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    TextButton(
                      style:
                          ButtonStyle(backgroundColor: createTextBtnBgColor()),
                      onPressed: () {
                        widget.onConfirm?.call();
                        HttpErrorBoundary._instance._dismiss();
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ).nestedExpanded(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
