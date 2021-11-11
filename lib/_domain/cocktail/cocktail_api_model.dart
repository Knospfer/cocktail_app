import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cocktail_api_model.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CocktailListApiResponse {
  final List<CocktailApiModel> drinks;

  const CocktailListApiResponse(this.drinks);

  factory CocktailListApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CocktailListApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailListApiResponseToJson(this);
}

@immutable
@JsonSerializable()
class CocktailApiModel {
  final String dateModified;
  final String idDrink;
  final String strAlcoholic;
  final String strCategory;
  final String strDrink;
  final String? strCreativeCommonsConfirmed;
  final String? strDrinkAlternate;
  final String? strDrinkThumb;
  final String? strGlass;
  final String? strIBA;
  final String? strImageAttribution;
  final String? strImageSource;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strInstructions;
  final String? strInstructionsDE;
  final String? strInstructionsES;
  final String? strInstructionsFR;
  final String? strInstructionsIT;
  @JsonKey(name: "strInstructionsZH-HANS")
  final String? strInstructionsZhHans;
  @JsonKey(name: "strInstructionsZH-HANT")
  final String? strInstructionsZhHant;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;
  final String? strTags;
  final String? strVideo;

  const CocktailApiModel(
    this.dateModified,
    this.idDrink,
    this.strAlcoholic,
    this.strCategory,
    this.strDrink,
    this.strCreativeCommonsConfirmed,
    this.strDrinkAlternate,
    this.strDrinkThumb,
    this.strGlass,
    this.strIBA,
    this.strImageAttribution,
    this.strImageSource,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strInstructions,
    this.strInstructionsDE,
    this.strInstructionsES,
    this.strInstructionsFR,
    this.strInstructionsIT,
    this.strInstructionsZhHans,
    this.strInstructionsZhHant,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strTags,
    this.strVideo,
  );

  factory CocktailApiModel.fromJson(Map<String, dynamic> json) =>
      _$CocktailApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailApiModelToJson(this);
}
