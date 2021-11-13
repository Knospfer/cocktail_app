import 'package:cocktail_app/_core/services/api/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters_model.g.dart';

@immutable
@JsonSerializable()
class CategoryModel extends Serializable {
  final String strCategory;

  const CategoryModel(this.strCategory);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@immutable
@JsonSerializable()
class IngredientModel extends Serializable {
  @JsonKey(name: "strIngredient1")
  final String strIngredient;

  const IngredientModel(this.strIngredient);

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
}

@immutable
@JsonSerializable()
class AlcoholicModel extends Serializable {
  final String strAlcoholic;

  const AlcoholicModel(this.strAlcoholic);

  factory AlcoholicModel.fromJson(Map<String, dynamic> json) =>
      _$AlcoholicModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlcoholicModelToJson(this);
}
