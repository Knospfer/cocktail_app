import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_card.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/main_screen_scaffold.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list.dart';
import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
import 'package:cocktail_app/screens/search/utils/show_search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<StaggeredSliverListState<CocktailEntity>>();
  bool _firstCall = true;
  bool _isSearching = false;

  @override
  void initState() {
    _fetchCocktails();
    super.initState();
  }

  _toggleFavourites(CocktailEntity cocktail) =>
      fetchViewModel<HomeViewModel>(context).toggleFavourite(cocktail);

  _fetchCocktails({ApplyingFilterEntity? filter}) =>
      fetchViewModel<HomeViewModel>(context).fetchCocktailList(filter: filter);

  Future<void> _navigateToDetail(CocktailEntity cocktail) async {
    Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: cocktail,
    );
  }

  bool _shouldUpdateCardList(List<CocktailEntity> cocktails) =>
      cocktails.isNotEmpty && (_firstCall || _isSearching);

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      title: "Hey",
      subtitle: "What would you \nlike to drink tonight?",
      onSearchPressed: () async {
        _isSearching = true;
        final filter = await showSearchBottomSheet(context);
        await _fetchCocktails(filter: filter);
      },
      children: [
        Consumer<HomeViewModel>(
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
              builder: (cocktail) {
                return GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    _navigateToDetail(cocktail);
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
