import 'package:cocktail_app/app_root_screen.dart';
import 'package:flutter/material.dart';

@immutable
class Routes {
  static const String root = "/root";

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return _pageRoute(settings, (_) => const AppRootScreen());
      default:
        throw (Exception("Route not found!"));
    }
  }

  static MaterialPageRoute _pageRoute(
    RouteSettings settings,
    WidgetBuilder builder, {
    bool fullscreenDialog = false,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }
}
