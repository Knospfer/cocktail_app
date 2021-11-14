import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_core/services/api/api.service.dart';
import 'package:cocktail_app/_core/services/api/api_response.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/model/cocktail_api_model.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class CocktailService {
  final ApiService _api;

  const CocktailService(this._api);

  Future<List<CocktailEntity>> fetchCocktailList({
    ApplyingFilterEntity? filter,
  }) async {
    final queryString = filter?.name ?? '';
    final rawResponse = await _api.get("/search.php?s=$queryString");
    final apiResponse = ApiResponse<CocktailApiModel>.fromJson(rawResponse);

    return apiResponse.drinks
        .map((e) => CocktailEntity.fromApiModel(e))
        .toList();
  }

  //TODO FILTRO

  String _composeQueryString(ApplyingFilterEntity? filter) {
    if (filter == null) return "";

    String queryString = "";

    if (filter.name != null) {
      queryString += "s=${filter.name}";
    }
    if (filter.alcoholPresence != null) {
      queryString = _conditionalAppendQueryItemTo(queryString) +
          "a=${_alcoholPresenceToString(filter.alcoholPresence!)}";
    }
    if (filter.category != null) {
      queryString =
          _conditionalAppendQueryItemTo(queryString) + "c=${filter.category}";
    }
    if (filter.ingredients != null) {
      queryString = _conditionalAppendQueryItemTo(queryString) +
          "i=" +
          _composeIngredientQueryString(filter.ingredients!);
    }

    return queryString;
  }

  String _conditionalAppendQueryItemTo(String queryStirng) {
    if (queryStirng.isNotEmpty) queryStirng += "&";
    return queryStirng;
  }

  String _alcoholPresenceToString(AlcoholPresence alcoholPresence) {
    switch (alcoholPresence) {
      case AlcoholPresence.present:
        return "Alcoholic";
      case AlcoholPresence.absent:
        return "Non_Alcoholic";
      case AlcoholPresence.optional:
        return "Optional";
      default:
        throw Exception("Invalid value!");
    }
  }

  String _composeIngredientQueryString(List<String> ingredients) {
    String queryString = "";
    for (final item in ingredients) {
      if (queryString.isNotEmpty) queryString += "&";
      queryString += item;
    }
    return queryString;
  }
}
