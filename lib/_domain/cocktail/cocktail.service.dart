import 'package:cocktail_app/_core/services/api.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'cocktail.store.dart';
import 'cocktail_api_model.dart';
import 'cocktail_entity.dart';

@lazySingleton
@immutable
class CocktailService {
  final ApiService _api;
  final CocktailStore _favouriteStore;

  const CocktailService(this._api, this._favouriteStore);

  Future<List<CocktailEntity>> fetchCocktailList() async {
    final rawResponse = await _api.get("/search.php?s=");
    final apiModelResponse = CocktailListApiResponse.fromJson(rawResponse);

    return apiModelResponse.drinks
        .map((model) => CocktailEntity.fromApiModel(model))
        .toList();
  }

  Future<void> saveCocktailToFavourites(CocktailEntity cocktail) async {
    _favouriteStore.add(cocktail);
  }
}
