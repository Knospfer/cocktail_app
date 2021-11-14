import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_favourite_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailViewModel extends ChangeNotifier with CocktailFavouriteHandler {
  
  Future<void> toggle(CocktailEntity cocktail) async {
    await toggleFavourite(cocktail);
    notifyListeners();
  }
}
