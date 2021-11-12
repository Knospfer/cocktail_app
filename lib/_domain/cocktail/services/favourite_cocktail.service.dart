
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
@immutable
class FavouriteCocktailService {
  final CocktailStore _favouriteStore;

  const FavouriteCocktailService(this._favouriteStore);

  Future<void> saveCocktailToFavourites(CocktailEntity cocktail) async {
    cocktail.favourite = true;
    _favouriteStore.add(cocktail);
  }

  Future<List<CocktailEntity>> fetchCocktailFavourites() async =>
      _favouriteStore.get();
}
