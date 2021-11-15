import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/app_root_screen.dart';
import 'package:cocktail_app/dependency_injection.dart';
import 'package:cocktail_app/screens/detail/screen/detail_screen.dart';
import 'package:cocktail_app/screens/detail/view_model/detail_view_model.dart';
import 'package:cocktail_app/screens/login/screen/login_screen.dart';
import 'package:cocktail_app/screens/login/view_model/login_view_model.dart';
import 'package:cocktail_app/screens/qr/screens/qr_modal.dart';
import 'package:cocktail_app/screens/qr/screens/qr_scanner.dart';
import 'package:cocktail_app/screens/qr/view_model/qr_scanner_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class Routes {
  static const String login = "/";
  static const String root = "/root";
  static const String detail = "/detail";
  static const String showQR = "/show_qr";
  static const String qrScanner = "/qr_scanner";

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return _pageRoute(settings, (_) => const AppRootScreen());
      case detail:
        return _pageRoute(
          settings,
          (_) => ChangeNotifierProvider(
            create: (_) => getIt<DetailViewModel>(),
            child: DetailScreen(cocktail: settings.arguments as CocktailEntity),
          ),
        );
      case showQR:
        return _pageRoute(
          settings,
          (_) => QrModalScreen(cocktail: settings.arguments as CocktailEntity),
          fullscreenDialog: true,
        );
      case qrScanner:
        return _pageRoute(
          settings,
          (_) => ChangeNotifierProvider(
            create: (_) => getIt<QrScannerScreenViewModel>(),
            child: const QrScannerScreen(),
          ),
          fullscreenDialog: true,
        );
      case login:
        return _pageRoute(
          settings,
          (context) => ChangeNotifierProvider(
            create: (_) => getIt<LoginViewModel>(),
            child: LoginScreen(),
          ),
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
