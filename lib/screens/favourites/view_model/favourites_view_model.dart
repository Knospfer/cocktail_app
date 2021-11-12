import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavouritesViewModel extends ChangeNotifier {
  final FavouriteCocktailService _favouriteCocktailService;

  List<CocktailEntity> cocktails = [];

  FavouritesViewModel(this._favouriteCocktailService);

  Future<void> fetchFavourites() async {
    cocktails = await _favouriteCocktailService.fetchFavourites();
    notifyListeners();
  }

  Future<void> removeFromFavourites(CocktailEntity cocktail) async {
    await _favouriteCocktailService.removeFromFavourites(cocktail);
    cocktails
        .removeWhere((current) => current.id == cocktail.id); //TODO EQUATABLE
  }
}
