import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  final CocktailService _cocktailService;
  List<CocktailEntity> cocktails = [];

  HomeViewModel(this._cocktailService);

  Future<void> fetchCocktailList() async {
    cocktails = await _cocktailService.fetchCocktailList();
    notifyListeners();
  }
}
