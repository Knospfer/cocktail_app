import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_card.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/main_screen_scaffold.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list.dart';
import 'package:cocktail_app/screens/favourites/view_model/favourites_view_model.dart';
import 'package:cocktail_app/screens/search/utils/show_search_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final _key = GlobalKey<StaggeredSliverListState<CocktailEntity>>();
  bool _firstCall = true;
  bool _isSearching = false;

  @override
  void initState() {
    _fetchFavourites();
    super.initState();
  }

  _fetchFavourites() =>
      fetchViewModel<FavouritesViewModel>(context).fetchFavourites();

  _searchFavourite({ApplyingFilterEntity? filter}) =>
      fetchViewModel<FavouritesViewModel>(context)
          .seachFavourite(filter: filter);

  _removeFromFavourites(int index, CocktailEntity cocktail) {
    fetchViewModel<FavouritesViewModel>(context).removeFromFavourites(cocktail);
    _key.currentState?.removeItem(index, cocktail);
  }

  Future<void> _navigateToDetail(int index, CocktailEntity cocktail) async {
    final selectedCocktail = await Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: cocktail,
    );
    _checkUpdatedCocktailStillFavourite(
        index, selectedCocktail as CocktailEntity, cocktail);
  }

  void _checkUpdatedCocktailStillFavourite(
    int oldIndex,
    CocktailEntity? updatedCocktail,
    CocktailEntity oldCocktail,
  ) {
    if (updatedCocktail == null) {
      _key.currentState?.removeItem(oldIndex, oldCocktail);
      return;
    }
    if (!updatedCocktail.favourite) {
      _key.currentState?.removeItem(oldIndex, oldCocktail);
      return;
    }
  }

  bool _shouldUpdateCardList(List<CocktailEntity> cocktails) =>
      cocktails.isNotEmpty && (_firstCall || _isSearching);

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      title: "Hey",
      subtitle: "Here's your \nfavourite cocktails",
      onSearchPressed: () async {
        _isSearching = true;
        final filter = await showSearchBottomSheet(context);
        if (filter != null) await _searchFavourite(filter: filter);
      },
      children: [
        Consumer<FavouritesViewModel>(
          builder: (context, viewModel, child) {
            final cocktails = viewModel.cocktails;

            if (_shouldUpdateCardList(cocktails) && _isSearching) {
              _key.currentState?.emptyList();
            }

            if (_shouldUpdateCardList(cocktails)) {
              _firstCall = false;
              _isSearching = false;
              _key.currentState?.addItemsStaggered(cocktails);
            }

            return StaggeredSliverList<CocktailEntity>(
              key: _key,
              builder: (index, cocktail) {
                return GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    if (cocktail.favourite) _navigateToDetail(index, cocktail);
                  },
                  child: CocktailCard(
                    onFavouriteTapped: () {
                      _removeFromFavourites(index, cocktail);
                    },
                    cocktail: cocktail,
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
