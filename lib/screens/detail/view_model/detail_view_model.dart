import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailViewModel extends CocktailFavouriteHandler {
  DetailViewModel(FavouriteCocktailService favouriteCocktailService)
      : super(favouriteCocktailService);

  @override
  Future<void> toggleFavourite(CocktailEntity cocktail) async {
    await super.toggleFavourite(cocktail);
    notifyListeners();
  }
}
