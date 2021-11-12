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
    Provider.of<HomeViewModel>(context, listen: false).fetchCocktailList();
    super.initState();
  }

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
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.detail,
                            arguments: cocktail,
                          );
                        },
                        child: CocktailCard(
                          cocktail: cocktail,
                          onFavouriteTapped: () {
                            _addToFavourites(cocktail);
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

  _addToFavourites(CocktailEntity cocktail) =>
      Provider.of<HomeViewModel>(context, listen: false)
          .addToFavourites(cocktail);
}
