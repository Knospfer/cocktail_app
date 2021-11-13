import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_card.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/main_screen_scaffold.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list.dart';
import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
import 'package:cocktail_app/screens/search/builder/search_bottom_sheet_builder.dart';
import 'package:cocktail_app/screens/search/screen/search_bottom_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<StaggeredSliverListState<CocktailEntity>>();

  @override
  void initState() {
    _fetchCocktails();
    super.initState();
  }

  _toggleFavourites(CocktailEntity cocktail) =>
      Provider.of<HomeViewModel>(context, listen: false)
          .toggleFavourite(cocktail);

  _fetchCocktails() =>
      Provider.of<HomeViewModel>(context, listen: false).fetchCocktailList();

  Future<void> _navigateToDetail(CocktailEntity cocktail) async {
    await Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: cocktail,
    );

    ///for semplicity reloads cocktails list to refresh favourite state.
    ///In more complex situation, is to prefer use a stream listening
    ///to database status
    await _fetchCocktails();
  }

  Future _showSearchBottomSheet() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => const SearchBottomSheetBuilder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      title: "Hey",
      subtitle: "What would you \nlike to drink tonight?",
      onSearchPressed: _showSearchBottomSheet,
      children: [
        Consumer<HomeViewModel>(
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
