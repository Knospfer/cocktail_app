import 'dart:async';
import 'package:cocktail_app/_core/view_model/reactive_view_model.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends ReactiveViewModel with CocktailFavouriteHandler {
  final CocktailService _cocktailService;

  HomeViewModel(
    this._cocktailService,
    CocktailStore _favouritesStore,
  ) : super(_favouritesStore);

  Future<void> fetchCocktailList({ApplyingFilterEntity? filter}) async {
    final result = await _cocktailService.fetchCocktailList(filter: filter);
    updateDataFetchedFromApi(result);
  }

  ///Creates a Map with {idEntity: Entity} from an array.
  ///In this way will be much faster (o(1)) check if some item
  ///is present into the array (o(N))
  @override
  List<CocktailEntity> mergeApiWithStoreList({
    required List<CocktailEntity> apiCocktails,
    required List<CocktailEntity> favourites,
  }) {
    final Map<String, CocktailEntity?> favouriteMap =
        favourites.asMap().map((key, value) => MapEntry(value.id, value));

    final mapped = apiCocktails.map((entity) {
      entity.favourite = favouriteMap[entity.id] != null;
      return entity;
    }).toList();

    return mapped;
  }
}
