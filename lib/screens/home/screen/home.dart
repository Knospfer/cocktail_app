import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card.dart';
import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
import 'package:cocktail_app/_shared/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: ScreenHeader(
                title: "Hey",
                subtitle: "What would you \nlike to drink tonight?",
              ),
            ),
            Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                final cocktailList = viewModel.cocktails;

                if (cocktailList.isNotEmpty) {
                  return SliverAnimatedList(
                    initialItemCount: cocktailList.length,
                    itemBuilder: (context, index, animation) {
                      final cocktail = cocktailList[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.deferToChild,
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            Routes.detail,
                            arguments: cocktail,
                          );

                          ///for semplicity reloads cocktails list to refresh favourite state.
                          ///In more complex situation, is to prefer use a stream listening
                          ///to database status
                          await _fetchCocktails();
                        },
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: CocktailCard(
                            onFavouriteTapped: () {
                              _toggleFavourites(cocktail);
                            },
                            cocktail: cocktail,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
