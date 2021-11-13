import 'package:cocktail_app/_domain/cocktail/model/cocktail_api_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ApiResponse {
  final List<CocktailApiModel> drinks;

  const ApiResponse(this.drinks);

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
