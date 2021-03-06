import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  final bool isFavourite;
  final void Function() onFavouriteTapped;

  const FavouriteButton({
    Key? key,
    required this.isFavourite,
    required this.onFavouriteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: onFavouriteTapped,
      icon: isFavourite
          ? const Icon(
              Icons.favorite,
              color: ColorPalette.white,
            )
          : const Icon(
              Icons.favorite_border,
              color: ColorPalette.white,
            ),
    );
  }
}
