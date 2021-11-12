import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_domain/cocktail/data/cocktail_api_model.dart';


class CocktailEntity {
  final String id;
  final String name;
  final String? instructions;
  final String category;
  final String? image;
  late final List<String?> ingredients;
  late final AlcoholPresence alcoholPresence;
  final bool favourite;

  CocktailEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.alcoholPresence,
    required this.ingredients,
    this.instructions,
    this.image,
    this.favourite = false,
  });

  CocktailEntity.fromApiModel(CocktailApiModel model)
      : id = model.idDrink,
        name = model.strDrink,
        instructions = model.strInstructions,
        category = model.strCategory,
        image = model.strDrinkThumb,
        favourite = false,
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
