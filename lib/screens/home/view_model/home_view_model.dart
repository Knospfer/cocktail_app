import 'dart:async';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/services/favourite_cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class HomeViewModel extends CocktailFavouriteHandler {
  final CocktailService _cocktailService;
  final CocktailStore _favouritesStore;

  final _cocktailSubject = BehaviorSubject<List<CocktailEntity>>();
  late final StreamSubscription<List<CocktailEntity>> _subscription;

  List<CocktailEntity> cocktails = [];

  HomeViewModel(
    this._cocktailService,
    this._favouritesStore,
    FavouriteCocktailService _favouriteCocktailService,
  ) : super(_favouriteCocktailService) {
    _subscription = CombineLatestStream(
      [_favouritesStore.storeStatus, _cocktailSubject.stream],
      _mapApiCocktailWithPersitentFavourites,
    ).listen(_updateCocktailStatus);
  }

  Future<void> fetchCocktailList() async {
    final result = await _cocktailService.fetchCocktailList();
    _cocktailSubject.add(result);
  }

  List<CocktailEntity> _mapApiCocktailWithPersitentFavourites(List items) {
    final favourites = items.elementAt(0) as List<CocktailEntity>;
    final apiCocktails = items.elementAt(1) as List<CocktailEntity>;

    return _cocktailsWithFavouriteStatus(
      cocktails: apiCocktails,
      favourites: favourites,
    );
  }

  ///Creates a Map with {idEntity: Entity} from an array.
  ///In this way will be much faster (o(1)) check if some item
  ///is present into the array (o(N))
  List<CocktailEntity> _cocktailsWithFavouriteStatus({
    required List<CocktailEntity> cocktails,
    required List<CocktailEntity> favourites,
  }) {
    final Map<String, CocktailEntity?> favouriteMap =
        favourites.asMap().map((key, value) => MapEntry(value.id, value));

    return cocktails.map((entity) {
      entity.favourite = favouriteMap[entity.id] != null;
      return entity;
    }).toList();
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
