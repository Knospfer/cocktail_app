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
    if (filter == null || filter.name == null) {
      return _searchCocktailList(name: filter?.name);
    }
    final idList = await _findCocktailList(filter: filter);
    final List<CocktailEntity> completeList = [];

    ///IMPROVE: this is NOT ideal. In this way the app
    ///can expose the server to a severe overhead
    ///and the app seems slow during the wait
    await Future.forEach<CocktailApiModel>(idList.take(filter.itemPerSearch),
        (element) async {
      final completeItem = await _findElementBy(element.idDrink);
      completeList.add(completeItem);
    });
    return completeList;
  }

  Future<List<CocktailEntity>> _searchCocktailList({String? name}) async {
    final queryString = name ?? '';
    return _handleApiCall("/search.php?s=$queryString");
  }

  Future<List<CocktailApiModel>> _findCocktailList({
    ApplyingFilterEntity? filter,
  }) async {
    final queryString = _composeQueryString(filter);
    final rawResponse = await _api.get("/filter.php?$queryString");
    final apiResponse = ApiResponse<CocktailApiModel>.fromJson(rawResponse);
    return apiResponse.drinks;
  }

  Future<CocktailEntity> _findElementBy(String id) async {
    final response = await _handleApiCall("/lookup.php?i=$id");
    return response.first;
  }

  Future<List<CocktailEntity>> _handleApiCall(String path) async {
    final rawResponse = await _api.get(path);
    final apiResponse = ApiResponse<CocktailApiModel>.fromJson(rawResponse);

    return apiResponse.drinks
        .map((e) => CocktailEntity.fromApiModel(e))
        .toList();
  }

  String _composeQueryString(ApplyingFilterEntity? filter) {
    if (filter == null) return "";

    String queryString = "";

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
        return "Optional_alcohol";
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
