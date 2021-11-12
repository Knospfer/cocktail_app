import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:flutter/material.dart';

class CocktailFavouriteHandler extends ChangeNotifier {
  final FavouriteCocktailService _favouriteCocktailService;

  CocktailFavouriteHandler(this._favouriteCocktailService);

  Future<void> addToFavourites(CocktailEntity cocktail) async {
    await _favouriteCocktailService.addToFavourites(cocktail);
    notifyListeners();
  }

  Future<void> removeToFavourites(CocktailEntity cocktail) async {
    await _favouriteCocktailService.removeFromFavourites(cocktail);
    notifyListeners();
  }
}