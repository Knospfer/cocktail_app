import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends CocktailFavouriteHandler {
  final CocktailService _cocktailService;
  List<CocktailEntity> cocktails = [];

  HomeViewModel(
    this._cocktailService,
    FavouriteCocktailService _favouriteCocktailService,
  ) : super(_favouriteCocktailService);

  Future<void> fetchCocktailList() async {
    cocktails = await _cocktailService.fetchCocktailList();
    notifyListeners();
  }
}
