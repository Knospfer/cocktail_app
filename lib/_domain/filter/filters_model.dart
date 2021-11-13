import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters_model.g.dart';

@immutable
@JsonSerializable()
class CategoryModel {
  final String strCategory;

  const CategoryModel(this.strCategory);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@immutable
@JsonSerializable()
class IngredientModel {
  @JsonKey(name: "strIngredient1")
  final String strIngredient;

  const IngredientModel(this.strIngredient);

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
}

@immutable
@JsonSerializable()
class AlcoholicModel {
  final String strAlcoholic;

  const AlcoholicModel(this.strAlcoholic);

  factory AlcoholicModel.fromJson(Map<String, dynamic> json) =>
      _$AlcoholicModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcoholicModelToJson(this);
}
