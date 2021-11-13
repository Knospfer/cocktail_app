import 'package:cocktail_app/_core/services/api/api.service.dart';
import 'package:cocktail_app/_core/services/api/api_response.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/model/cocktail_api_model.dart';
import 'package:cocktail_app/_domain/cocktail/store/cocktail.store.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class CocktailService {
  final ApiService _api;
  final CocktailStore _favouriteStore;

  const CocktailService(this._api, this._favouriteStore);

  Future<List<CocktailEntity>> fetchCocktailList() async {
    final rawResponse = await _api.getValue("/search.php?s=");
    final apiModelResponse =
        ApiResponse<CocktailApiModel>.fromJson(rawResponse);

    return await _cocktailsWithFavouriteStatus(apiModelResponse);
  }

  Future<List<CocktailEntity>> _cocktailsWithFavouriteStatus(
    ApiResponse<CocktailApiModel> apiModelResponse,
  ) async {
    final Map<String, CocktailEntity?> favouriteMap =
        await _createFavouriteMap();

    return apiModelResponse.drinks.map((model) {
      final entity = CocktailEntity.fromApiModel(model);
      entity.favourite = favouriteMap[entity.id] != null;

      return entity;
    }).toList();
  }

  ///Creates a Map with {idEntity: Entity} from an array.
  ///In this way will be much faster (o(1)) check if some item
  ///is present into the array (o(N))
  Future<Map<String, CocktailEntity?>> _createFavouriteMap() async {
    final favourites = await _favouriteStore.get();
    return favourites.asMap().map((key, value) => MapEntry(value.id, value));
  }
}
