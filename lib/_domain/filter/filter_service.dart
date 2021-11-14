import 'package:cocktail_app/_core/services/api/api.service.dart';
import 'package:cocktail_app/_core/services/api/api_response.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_domain/filter/filters_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilterService {
  final ApiService _apiService;

  FilterService(this._apiService);

  Future<FilterDataEntity> fillFilter() async {
    final categories = await _getCategories();
    final ingredients = await _getIngredients();
    final alcoholPresence = await _getAlcoholic();

    return FilterDataEntity(
      categories: categories,
      ingredients: ingredients,
      alcoholPresence: alcoholPresence,
    );
  }

  Future<ApiResponse<T>> _getApiResponse<T extends Serializable>(
    String path,
  ) async {
    final rawList = await _apiService.get(path);
    return ApiResponse<T>.fromJson(rawList);
  }

  Future<List<String>> _getCategories() async {
    final apiResponse = await _getApiResponse<CategoryModel>(
      "/list.php?c=list",
    );
    return apiResponse.drinks.map((e) => e.strCategory).toList();
  }

  Future<List<String>> _getIngredients() async {
    final apiResponse = await _getApiResponse<IngredientModel>(
      "/list.php?i=list",
    );
    return apiResponse.drinks.map((e) => e.strIngredient).toList();
  }

  Future<List<String>> _getAlcoholic() async {
    final apiResponse = await _getApiResponse<AlcoholicModel>(
      "/list.php?a=list",
    );
    return apiResponse.drinks.map((e) => e.strAlcoholic).toList();
  }
}
