import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
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

class _FavouritesScreenState extends State<FavouritesScreen> {
  final _key = GlobalKey<StaggeredSliverListState<CocktailEntity>>();

  @override
  void initState() {
    _fetchFavourites();
    super.initState();
  }

  _fetchFavourites() => Provider.of<FavouritesViewModel>(context, listen: false)
      .fetchFavourites();

  _removeFromFavourites(CocktailEntity cocktail) {
    Provider.of<FavouritesViewModel>(context, listen: false)
        .removeFromFavourites(cocktail);
    _key.currentState?.removeItem(cocktail);
  }

  Future<void> _navigateToDetail(CocktailEntity cocktail) async {
    final selectedCocktail = await Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: cocktail,
    );
    _checkUpdatedCocktailStillFavourite(
        selectedCocktail as CocktailEntity, cocktail);
  }

  void _checkUpdatedCocktailStillFavourite(
    CocktailEntity? updatedCocktail,
    CocktailEntity oldCocktail,
  ) {
    if (updatedCocktail == null) {
      _key.currentState?.removeItem(oldCocktail);
      return;
    }
    if (!updatedCocktail.favourite) {
      _key.currentState?.removeItem(oldCocktail);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      title: "Hey",
      subtitle: "Here's your \nfavourite cocktails",
      onSearchPressed: () {},
      children: [
        Consumer<FavouritesViewModel>(
          builder: (context, viewModel, child) {
            final cocktails = viewModel.cocktails;

            if (cocktails.isNotEmpty) {
              _key.currentState?.addItemsStaggered(cocktails);
            }

            return StaggeredSliverList<CocktailEntity>(
              key: _key,
              builder: (cocktail) {
                return GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    if (cocktail.favourite) _navigateToDetail(cocktail);
                  },
                  child: CocktailCard(
                    onFavouriteTapped: () {
                      _removeFromFavourites(cocktail);
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
