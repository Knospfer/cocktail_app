import 'package:cocktail_app/_core/store/store.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

@singleton
class CocktailStore extends Store<CocktailEntity> {
  CocktailStore(Database database) : super(database, name: "cocktails");

  @override
  String getItemKey(item) => item.id;

  @override
  Map<String, dynamic> itemToJson(item) => item.toJson();

  @override
  CocktailEntity fromJson(Map<String, dynamic> json) =>
      CocktailEntity.fromJson(json);
}
