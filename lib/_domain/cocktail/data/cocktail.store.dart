import 'package:cocktail_app/_core/store/store.dart';
import 'package:cocktail_app/_domain/cocktail/data/cocktail_api_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

@singleton
class CocktailStore extends Store<CocktailApiModel> {
  CocktailStore(Database database) : super(database, name: "cocktails");

  @override
  String getItemKey(item) => item.idDrink;

  @override
  Map<String, dynamic> itemToJson(item) => item.toJson();

  @override
  CocktailApiModel fromJson(Map<String, dynamic> json) =>
      CocktailApiModel.fromJson(json);
}
