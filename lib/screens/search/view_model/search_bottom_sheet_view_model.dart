import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_domain/filter/filter_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchBottomSheetViewModel extends ChangeNotifier {
  final FilterService _filterService;
  FilterDataEntity? filterData;
  ApllyingFilterEntity? filter;

  SearchBottomSheetViewModel(this._filterService);

  Future<void> createSearchFilter() async {
    filterData = await _filterService.fillFilter();
    notifyListeners();
  }

  void updateFilter({
    String? name,
    String? category,
    AlcoholPresence? alcoholPresence,
    List<String>? ingredients,
  }) {
    filter ??= ApllyingFilterEntity();
    if (name != null) filter?.name = name;
    if (category != null) filter?.category = category;
    if (alcoholPresence != null) filter?.alcoholPresence = alcoholPresence;
    if (ingredients != null) filter?.ingredients = ingredients;
  }

  Future<List<CocktailEntity>?> applyFilter() =>
      _filterService.applyFilter(filter);
}
