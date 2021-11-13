import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_domain/filter/filter_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchBottomSheetViewModel extends ChangeNotifier {
  final FilterService _filterService;
  FilterDataEntity? filterData;

  SearchBottomSheetViewModel(this._filterService);

  Future<void> createSearchFilter() async {
    filterData = await _filterService.fillFilter();
    notifyListeners();
  }
}
