import 'dart:async';

import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class FavouritesViewModel extends ChangeNotifier {
  final FavouriteCocktailService _favouriteCocktailService;
  final CocktailService _cocktailService;
  final CocktailStore _favouritesStore;

  final _apiSubject = BehaviorSubject<List<CocktailEntity>>();
  late final StreamSubscription<List<CocktailEntity>> _subscription;

  List<CocktailEntity> cocktails = [];

  FavouritesViewModel(
    this._favouriteCocktailService,
    this._cocktailService,
    this._favouritesStore,
  ) {
    _subscription = CombineLatestStream(
      [_favouritesStore.storeStatus, _apiSubject.stream],
      _mapApiCocktailWithPersitentFavourites,
    ).listen(_updateCocktailStatus);
  }

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
    _apiSubject.add(result);
  }

  List<CocktailEntity> _mapApiCocktailWithPersitentFavourites(List items) {
    final favourites = items.elementAt(0) as List<CocktailEntity>;
    final apiCocktails = items.elementAt(1) as List<CocktailEntity>;

    return _cocktailsWithFavouriteStatus(
      apiCocktails: apiCocktails,
      favourites: favourites,
    );
  }

  ///Maps apiCocktails checking if items of apiCocktails
  ///are contained in favourites.
  ///To do so, transform favourites in a [Set] of ids,
  ///If api cokctail id can be added to the set,
  ///the item is not a favourite item, due to Set properties
  List<CocktailEntity> _cocktailsWithFavouriteStatus({
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

  void _updateCocktailStatus(List<CocktailEntity> newList) {
    cocktails = newList;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
