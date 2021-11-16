import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/presentation/cocktail_list_handler.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_card.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/main_screen_scaffold.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list.dart';
import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CocktailListHandler {
  @override
  void initState() {
    _fetchCocktails();
    super.initState();
  }

  Future<void> _toggleFavourites(CocktailEntity cocktail) =>
      fetchViewModel<HomeViewModel>(context).toggleFavourite(cocktail);

  Future<void> _fetchCocktails({ApplyingFilterEntity? filter}) =>
      fetchViewModel<HomeViewModel>(context).fetchCocktailList(filter: filter);

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      title: "Hey",
      subtitle: "What would you \nlike to drink tonight?",
      onSearchPressed: () => filterCocktails(
        context,
        searchCocktailCallback: _fetchCocktails,
      ),
      children: [
        Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            final cocktails = viewModel.cocktails;
            conditionalUpdateCardList(context, cocktails: cocktails);

            return StaggeredSliverList<CocktailEntity>(
              key: key,
              builder: (_, cocktail) {
                return GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    navigateToDetail(context, cocktail);
                  },
                  child: CocktailCard(
                    onFavouriteTapped: () {
                      _toggleFavourites(cocktail);
                    },
                    cocktail: cocktail,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
