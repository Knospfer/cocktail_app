import 'package:cocktail_app/_core/services/api/api.service.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_domain/filter/filters_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilterService {
  final ApiService _apiService;

  FilterService(this._apiService);

  //TODO APPLY FILTER

  Future<FillingFilterEntity> fillFilter() async {
    final categories = await _getCategories();
    final ingredients = await _getIngredients();
    final alcoholPresence = await _getAlcoholic();

    return FillingFilterEntity(
      categories: categories,
      ingredients: ingredients,
      alcoholPresence: alcoholPresence,
    );
  }

  Future<List<String>> _getCategories() async {
    final rawList = await _apiService.getList("/list.php?c=list");

    return rawList.map((e) => CategoryModel.fromJson(e).strCategory).toList();
  }

  Future<List<String>> _getIngredients() async {
    final rawList = await _apiService.getList("/list.php?i=list");

    return rawList
        .map((e) => IngredientModel.fromJson(e).strIngredient)
        .toList();
  }

  Future<List<String>> _getAlcoholic() async {
    final rawList = await _apiService.getList("/list.php?a=list");

    return rawList.map((e) => AlcoholicModel.fromJson(e).strAlcoholic).toList();
  }
}
