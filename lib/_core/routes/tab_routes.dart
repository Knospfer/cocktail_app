import 'package:cocktail_app/dependency_injection.dart';
import 'package:cocktail_app/screens/favourites/screen/favourites.dart';
import 'package:cocktail_app/screens/favourites/view_model/favourites_view_model.dart';
import 'package:cocktail_app/screens/home/screen/home.dart';
import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class TabRoutes {
  static const String home = "/home";
  static const String favourites = "/favourites";

  static List<Widget> buildTabRoutes() => [
        ChangeNotifierProvider(
          create: (_) => getIt<HomeViewModel>(),
          child: const HomeScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<FavouritesViewModel>(),
          child: const FavouritesScreen(),
        ),
      ];
}
