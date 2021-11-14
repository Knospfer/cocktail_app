import 'package:cocktail_app/_core/services/api/api.service.dart';
import 'package:cocktail_app/_core/services/api/api_response.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/model/cocktail_api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class CocktailService {
  final ApiService _api;

  const CocktailService(this._api);

  Future<List<CocktailEntity>> fetchCocktailList() async {
    final rawResponse = await _api.get("/search.php?s=");
    final apiModelResponse =
        ApiResponse<CocktailApiModel>.fromJson(rawResponse);

    return apiModelResponse.drinks
        .map((e) => CocktailEntity.fromApiModel(e))
        .toList();
  }
}
