import 'package:cocktail_app/_core/services/api.service.dart';
import 'package:cocktail_app/_domain/cocktail/cocktail_api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'cocktail_entity.dart';

@lazySingleton
@immutable
class CocktailService {
  final ApiService _api;

  const CocktailService(this._api);

  Future<List<CocktailEntity>> fetchCocktailList() async {
    final rawResponse = await _api.get("/search.php?s=");
    final apiModelResponse = CocktailListApiResponse.fromJson(rawResponse);
    
    return apiModelResponse.drinks
        .map((model) => CocktailEntity.fromApiModel(model))
        .toList();
  }
}
