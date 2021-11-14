import 'dart:async';

import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

///Reactive View Model merges steam coming from
///[CocktailStore] and data fetched from [APIs]
///
/// notifyListeners() is automatically called when
/// [updateDataFetchedFromApi] is called or when [CocktailStore] is updated
///
///override [mergeApiWithStoreList] to set the merge criteria
abstract class ReactiveViewModel extends ChangeNotifier {
  final CocktailStore _favouritesStore;

  final _apiSubject = BehaviorSubject<List<CocktailEntity>>();
  late final StreamSubscription<List<CocktailEntity>> _subscription;

  List<CocktailEntity> cocktails = [];

  ReactiveViewModel(this._favouritesStore) {
    _subscription = CombineLatestStream(
      [_favouritesStore.storeStatus, _apiSubject.stream],
      _mapApiCocktailWithPersitentFavourites,
    ).listen(_updateCocktailStatus);
  }

  @protected
  void updateDataFetchedFromApi(List<CocktailEntity> data) {
    _apiSubject.add(data);
  }

  
  List<CocktailEntity> _mapApiCocktailWithPersitentFavourites(List items) {
    final favourites = items.elementAt(0) as List<CocktailEntity>;
    final apiCocktails = items.elementAt(1) as List<CocktailEntity>;

    return mergeApiWithStoreList(
      apiCocktails: apiCocktails,
      favourites: favourites,
    );
  }

  @protected
  List<CocktailEntity> mergeApiWithStoreList({
    required List<CocktailEntity> apiCocktails,
    required List<CocktailEntity> favourites,
  });

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
