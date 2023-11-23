import 'package:flutter/material.dart';

///
class NavigatorUtil {
  static void push<T extends Object?>(
    BuildContext context,
    Widget widget, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) {
    Navigator.push<T>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget widget,
    RoutePredicate predicate, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) {
    Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
      predicate,
    );
  }

  static void pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget widget, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) {
    Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
