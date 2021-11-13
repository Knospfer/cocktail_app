import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_domain/filter/filter_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchBottomSheetViewModel extends ChangeNotifier {
  final FilterService _filterService;
  FilterDataEntity? filterData;
  ApllyingFilterEntity? applyFilter;

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
    applyFilter ??= ApllyingFilterEntity();
    if (name != null) applyFilter?.name = name;
    if (category != null) applyFilter?.category = category;
    if (alcoholPresence != null) applyFilter?.alcoholPresence = alcoholPresence;
    if (ingredients != null) applyFilter?.ingredients = ingredients;
  }
}
