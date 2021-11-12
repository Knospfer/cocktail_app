import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavouritesViewModel extends CocktailFavouriteHandler {
  final FavouriteCocktailService _favouriteCocktailService;
  
  FavouritesViewModel(this._favouriteCocktailService)
      : super(_favouriteCocktailService);

  Future<List<CocktailEntity>> fetchFavourites() async {
    return _favouriteCocktailService.fetchFavourites();
  }
}
