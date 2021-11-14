import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:cocktail_app/dependency_injection.dart';

mixin CocktailFavouriteHandler {
  Future<void> toggleFavourite(CocktailEntity cocktail) async {
    final favouriteCocktailService = getIt<FavouriteCocktailService>();
    
    cocktail.favourite
        ? await favouriteCocktailService.removeFromFavourites(cocktail)
        : await favouriteCocktailService.addToFavourites(cocktail);
  }
}
