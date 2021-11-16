import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_list_handler.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_card.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/main_screen_scaffold.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list.dart';
import 'package:cocktail_app/screens/favourites/view_model/favourites_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen>
    with CocktailListHandler {
  @override
  void initState() {
    _fetchFavourites();
    super.initState();
  }

  Future<void> _fetchFavourites() =>
      fetchViewModel<FavouritesViewModel>(context).fetchFavourites();

  Future<void> _searchFavourite({ApplyingFilterEntity? filter}) =>
      fetchViewModel<FavouritesViewModel>(context)
          .seachFavourite(filter: filter);

  void _removeFromFavourites(int index, CocktailEntity cocktail) {
    fetchViewModel<FavouritesViewModel>(context).removeFromFavourites(cocktail);
    key.currentState?.removeItem(index, cocktail);
  }

  Future<void> _navigateToDetail(int index, CocktailEntity cocktail) async {
    final selectedCocktail = await navigateToDetail(context, cocktail);
    _checkUpdatedCocktailStillFavourite(
      index,
      selectedCocktail as CocktailEntity,
      cocktail,
    );
  }

  void _checkUpdatedCocktailStillFavourite(
    int oldIndex,
    CocktailEntity? updatedCocktail,
    CocktailEntity oldCocktail,
  ) {
    if (updatedCocktail == null) {
      key.currentState?.removeItem(oldIndex, oldCocktail);
      return;
    }
    if (!updatedCocktail.favourite) {
      key.currentState?.removeItem(oldIndex, oldCocktail);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      title: "Hey",
      subtitle: "Here's your \nfavourite cocktails",
      onSearchPressed: () => filterCocktails(
        context,
        searchCocktailCallback: _searchFavourite,
        showRangeSelection: false,
      ),
      children: [
        Consumer<FavouritesViewModel>(
          builder: (context, viewModel, child) {
            final cocktails = viewModel.cocktails;
            conditionalUpdateCardList(context, cocktails: cocktails);

            return StaggeredSliverList<CocktailEntity>(
              key: key,
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
