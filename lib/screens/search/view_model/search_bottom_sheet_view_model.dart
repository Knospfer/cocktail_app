import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_domain/filter/filter_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchBottomSheetViewModel extends ChangeNotifier {
  final FilterService _filterService;
  FilterDataEntity? filterData;
  ApplyingFilterEntity? filter;

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
    int? itemPerSearch,
  }) {
    filter ??= ApplyingFilterEntity();
    if (name != null) filter?.name = name;
    if (category != null) filter?.category = category;
    if (alcoholPresence != null) filter?.alcoholPresence = alcoholPresence;
    if (ingredients != null) filter?.ingredients = ingredients;
    if (itemPerSearch != null) filter?.itemPerSearch = itemPerSearch;
  }
}
