import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavouritesViewModel extends CocktailFavouriteHandler {
  final FavouriteCocktailService _favouriteCocktailService;
  List<CocktailEntity> cocktails = [];

  FavouritesViewModel(this._favouriteCocktailService)
      : super(_favouriteCocktailService);

  Future<void> fetchFavourites() async {
    cocktails = await _favouriteCocktailService.fetchFavourites();
    notifyListeners();
  }

  Future<void> removeFromFavourites(CocktailEntity cocktail) async {
    //TODO MIGIORA MIXIN
    await _favouriteCocktailService.removeFromFavourites(cocktail);
    cocktails
        .removeWhere((current) => current.id == cocktail.id); //TODO EQUATABLE
  }
}
