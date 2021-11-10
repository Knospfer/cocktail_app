import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_domain/cocktail/cocktail_api_model.dart';
import 'package:flutter/material.dart';

@immutable
class CocktailEntity {
  final String id;
  final String name;
  final String? instructions;
  final String category;
  late final AlcoholPresence alcoholPresence;
  late final List<String?> ingredients;

  CocktailEntity.fromApiModel(CocktailApiModel model)
      : id = model.idDrink,
        name = model.strDrink,
        instructions = model.strInstructions,
        category = model.strCategory,
        ingredients = [
          model.strIngredient1,
          model.strIngredient2,
          model.strIngredient3,
          model.strIngredient4,
          model.strIngredient5,
          model.strIngredient6,
          model.strIngredient7,
          model.strIngredient8,
          model.strIngredient9,
          model.strIngredient10,
          model.strIngredient11,
          model.strIngredient12,
          model.strIngredient13,
          model.strIngredient14,
          model.strIngredient15,
        ] {
    switch (model.strAlcoholic) {
      case "Alcoholic":
        alcoholPresence = AlcoholPresence.present;
        break;
      case "Non alcoholic":
        alcoholPresence = AlcoholPresence.absent;
        break;
      case "Optional alcohol":
        alcoholPresence = AlcoholPresence.optional;
        break;
      default:
        throw Exception("Missing Alcohol Presence!");
    }
  }
}
