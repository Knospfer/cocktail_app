import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class FavouriteCocktailService {
  final CocktailStore _favouriteStore;

  const FavouriteCocktailService(this._favouriteStore);

  Future<List<CocktailEntity>> fetchFavourites() async => _favouriteStore.get();

  Future<void> addToFavourites(CocktailEntity cocktail) async {
    cocktail.favourite = true;
    _favouriteStore.add(cocktail);
  }

  Future<void> removeFromFavourites(CocktailEntity cocktail) async {
    cocktail.favourite = false;
    _favouriteStore.delete(cocktail);
  }
}
