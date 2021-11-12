import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card.dart';
import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
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
      body: Container(
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
        ),
        alignment: Alignment.center,
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text(
                  "Hi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Text(
                  "What would you like \nto drink tonight?",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ...viewModel.cocktails
                    .map(
                      (cocktail) => GestureDetector(
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
                        child: CocktailCard(
                          cocktail: cocktail,
                          onFavouriteTapped: () {
                            _toggleFavourites(cocktail);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
