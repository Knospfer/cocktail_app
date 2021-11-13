import 'package:cocktail_app/_domain/cocktail/model/cocktail_api_model.dart';
import 'package:cocktail_app/_domain/filter/filters_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ApiResponse<T extends Serializable> {
  @_Converter()
  final List<T> drinks;

  const ApiResponse(this.drinks);

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

abstract class Serializable {
  Map<String, dynamic> toJson();

  const Serializable();
}

class _Converter<T extends Serializable>
    implements JsonConverter<T, Map<String, dynamic>> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is! Map<String, dynamic>) return json as T;

    if (json.containsKey('idDrink')) {
      return CocktailApiModel.fromJson(json) as T;
    }
    if (json.containsKey('strCategory')) {
      return CategoryModel.fromJson(json) as T;
    }
    if (json.containsKey('strIngredient1')) {
      return IngredientModel.fromJson(json) as T;
    }
    if (json.containsKey('strAlcoholic')) {
      return AlcoholicModel.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Map<String, dynamic> toJson(T object) => object.toJson();
}
