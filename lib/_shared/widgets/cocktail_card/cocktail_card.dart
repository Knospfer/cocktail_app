import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/cocktail_card/cocktail_chip.dart';
import 'package:cocktail_app/_shared/widgets/favourite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16, top: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          SizedBox.expand(
            child: FadeInImage.memoryNetwork(
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              image: cocktail.image,
              fadeInDuration: const Duration(milliseconds: 200),
            ),
          ),
          Container(
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
                  style: const LargeTextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cocktail.category,
                        style: const MediumTextStyle()
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
        ],
      ),
    );
  }
}
