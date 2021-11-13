import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_chip.dart';
import 'package:cocktail_app/_shared/widgets/favourite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CocktailCard extends StatelessWidget {
  final CocktailEntity cocktail;
  final void Function() onFavouriteTapped;

  const CocktailCard({
    Key? key,
    required this.cocktail,
    required this.onFavouriteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(cocktail.image ?? ""),
        ),
      ),
      child: Container(
        color: Colors.black26,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CocktailChip(cocktail: cocktail),
            ),
            const Expanded(child: SizedBox()),
            Text(
              cocktail.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    cocktail.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                FavouriteButton(
                  isFavourite: cocktail.favourite,
                  onFavouriteTapped: onFavouriteTapped,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
