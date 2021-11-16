import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list.dart';
import 'package:cocktail_app/screens/search/utils/show_search_bottom_sheet.dart';
import 'package:flutter/material.dart';

///Use this mixin to handle [StaggeredSliverList]
///in screens such as [HomeScreen] and [FavouriteScreen]
///
///Bind StaggeredSliverList with [key] and call
///[conditionalUpdateCardList] to update item list
///if condition is valid
///
///Call [filterCocktails] to open the bottom sheet
///and update [_isSearching] status
mixin CocktailListHandler {
  final key = GlobalKey<StaggeredSliverListState<CocktailEntity>>();
  bool _firstCall = true;
  bool _isSearching = false;

  bool _shouldUpdateCardList(List<CocktailEntity> cocktails) =>
      (_firstCall && cocktails.isNotEmpty) || (_isSearching && !_firstCall);

  void conditionalUpdateCardList(List<CocktailEntity> cocktails) {
    if (_shouldUpdateCardList(cocktails) && _isSearching) {
      key.currentState?.emptyList();
    }

    if (_shouldUpdateCardList(cocktails)) {
      _firstCall = false;
      _isSearching = false;
      key.currentState?.addItemsStaggered(cocktails);
    }
  }

  Future<void> filterCocktails(
    BuildContext context,
    Future<void> Function({ApplyingFilterEntity? filter})
        searchCocktailCallback,
  ) async {
    _isSearching = true;
    final filter = await showSearchBottomSheet(context);
    return searchCocktailCallback(filter: filter);
  }

  Future<void> navigateToDetail(
    BuildContext context,
    CocktailEntity cocktail,
  ) async {
    Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: cocktail,
    );
  }
}
