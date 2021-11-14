import 'dart:async';

import 'package:cocktail_app/_core/view_model/reactive_view_model.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavouritesViewModel extends ReactiveViewModel {
  final FavouriteCocktailService _favouriteCocktailService;
  final CocktailService _cocktailService;

  FavouritesViewModel(
    this._favouriteCocktailService,
    this._cocktailService,
    CocktailStore _favouritesStore,
  ) : super(_favouritesStore);

  Future<void> fetchFavourites() async {
    cocktails = await _favouriteCocktailService.fetchFavourites();
    notifyListeners();
  }

  Future<void> removeFromFavourites(CocktailEntity cocktail) async {
    await _favouriteCocktailService.removeFromFavourites(cocktail);
    cocktails.removeWhere((current) => current.id == cocktail.id);
  }

  Future<void> seachFavourite({ApplyingFilterEntity? filter}) async {
    final result = await _cocktailService.fetchCocktailList(filter: filter);
    updateDataFetchedFromApi(result);
  }

  ///Maps apiCocktails checking if items of apiCocktails
  ///are contained in favourites.
  ///To do so, transform favourites in a [Set] of ids,
  ///If api cokctail id can be added to the set,
  ///the item is not a favourite item, due to Set properties
  @override
  List<CocktailEntity> mergeApiWithStoreList({
    required List<CocktailEntity> apiCocktails,
    required List<CocktailEntity> favourites,
  }) {
    final checkingSet = favourites.map((e) => e.id).toSet();
    final mappedApi = apiCocktails.where((element) {
      element.favourite = !checkingSet.add(element.id);
      return element.favourite;
    }).toList();

    return mappedApi;
  }
}
