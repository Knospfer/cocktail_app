import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/app_root_screen.dart';
import 'package:cocktail_app/screens/detail/screen/detail_screen.dart';
import 'package:flutter/material.dart';

@immutable
class Routes {
  static const String root = "/";
  static const String detail = "/detail";

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return _pageRoute(settings, (_) => const AppRootScreen());
      case detail:
        return _pageRoute(
          settings,
          (_) => DetailScreen(cocktail: settings.arguments as CocktailEntity),
        );
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
