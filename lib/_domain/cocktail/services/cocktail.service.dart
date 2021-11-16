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
    if (filter == null || filter.searchByNameMode) {
      return _searchCocktailList(name: filter?.name);
    }
    List<String> idList = await _findCocktailList(filter);
    final List<CocktailEntity> completeList = [];

    final int? itemPerSearch = filter.itemPerSearch;
    if (itemPerSearch != null && itemPerSearch <= 20) {
      idList = idList.take(itemPerSearch).toList();
    }

    ///IMPROVE: this is NOT ideal. In this way the app
    ///can expose the server to a severe overhead
    ///and the app seems slow during the wait
    await Future.forEach<String>(idList, (element) async {
      final completeItem = await findElementBy(element);
      completeList.add(completeItem);
    });
    return completeList;
  }

  Future<List<CocktailEntity>> _searchCocktailList({String? name}) async {
    final queryString = name ?? '';
    final rawResponse = await _api.get("/search.php?s=$queryString");
    final apiResponse = ApiResponse<CocktailApiModel>.fromJson(rawResponse);

    return apiResponse.drinks
        .map((e) => CocktailEntity.fromApiModel(e))
        .toList();
  }

  ///This is a workaround. The API set does not support
  ///query string concatenation (returns only the result of the
  ///last queryItem).
  ///This should be done server side
  Future<List<String>> _findCocktailList(
    ApplyingFilterEntity filter,
  ) async {
    List<List<String>> innerJoinList = [];

    final alcoholPresence = _alcoholPresenceToString(filter.alcoholPresence);
    await _findCocktailStep(innerJoinList, "/filter.php?a=$alcoholPresence");

    if (filter.category != null) {
      await _findCocktailStep(
        innerJoinList,
        "/filter.php?c=${filter.category}",
      );
    }
    if (filter.ingredients != null) {
      final ingredients = _composeIngredientQueryString(filter.ingredients!);
      await _findCocktailStep(
        innerJoinList,
        "/filter.php?i=$ingredients",
      );
    }

    return _innerJoinList(innerJoinList);
  }

  Future<void> _findCocktailStep(
    List<List<String>> innerJoinList,
    String apiPath,
  ) async {
    final rawResponse = await _api.get(apiPath);
    final apiResponse = ApiResponse<CocktailApiModel>.fromJson(rawResponse);
    innerJoinList.add(apiResponse.drinks.map((e) => e.idDrink).toList());
  }

  ///This method return the intersection of M lists of variables lenght
  ///This should be done server side
  List<String> _innerJoinList(List<List<String>> lists) {
    lists.sort((a, b) => b.length - a.length);
    final shortestList = lists.removeLast();
    final setLists = lists.map((e) => e.toSet()).toList();
    final result = [...shortestList];

    for (final setList in setLists) {
      for (final item in shortestList) {
        if (setList.add(item)) {
          result.remove(item);
        }
      }
    }

    return result;
  }

  Future<CocktailEntity> findElementBy(String id) async {
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
