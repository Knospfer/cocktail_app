import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/favourite_button.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:cocktail_app/screens/detail/view_model/detail_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatefulWidget {
  final CocktailEntity cocktail;

  const DetailScreen({Key? key, required this.cocktail}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cocktail = widget.cocktail;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, widget.cocktail);
          return false;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: ColorPalette.black,
              expandedHeight: screenSize.height / 2.5,
              actions: [
                IconButton(
                  onPressed: () {
                    //TODO genera qr
                  },
                  icon: const Icon(
                    Icons.ios_share_outlined,
                  ), //TODO icona per ios e per android
                ),
                Consumer<DetailViewModel>(
                  builder: (context, viewModel, child) {
                    return FavouriteButton(
                      isFavourite: widget.cocktail.favourite,
                      onFavouriteTapped: () {
                        fetchViewModel<DetailViewModel>(context)
                            .toggleFavourite(widget.cocktail);
                      },
                    );
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  foregroundDecoration:
                      const BoxDecoration(color: Colors.black38),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.cocktail.image,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 200),
                  ),
                ),
                title: Text(
                  widget.cocktail.name,
                  style: const TextStyle(
                    color: ColorPalette.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const VerticalPadding(padding: 10),
                    Text(
                      cocktail.name,
                      style: TextStyle(
                          color: ColorPalette.white.withAlpha(200),
                          fontSize: 16),
                    ),
                    Divider(
                      color: ColorPalette.white.withAlpha(100),
                    ),
                    const Text(
                      "Category",
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const VerticalPadding(padding: 10),
                    Text(
                      cocktail.category,
                      style: TextStyle(
                          color: ColorPalette.white.withAlpha(200),
                          fontSize: 16),
                    ),
                    Divider(
                      color: ColorPalette.white.withAlpha(100),
                    ),
                    const Text(
                      "Alcoholic",
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const VerticalPadding(padding: 10),
                    Text(
                      cocktail.alcoholPresence.toString(),
                      style: TextStyle(
                          color: ColorPalette.white.withAlpha(200),
                          fontSize: 16),
                    ),
                    Divider(
                      color: ColorPalette.white.withAlpha(100),
                    ),
                    const Text(
                      "Instruction",
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const VerticalPadding(padding: 10),
                    Text(
                      cocktail.instructions ?? "Not present",
                      style: TextStyle(
                          color: ColorPalette.white.withAlpha(200),
                          fontSize: 16),
                    ),
                    Divider(
                      color: ColorPalette.white.withAlpha(100),
                    ),
                    const Text(
                      "Ingredients",
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const VerticalPadding(padding: 10),
                    ...cocktail.ingredients.map(
                      (i) => Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          i ?? "",
                          style: TextStyle(
                            color: ColorPalette.white.withAlpha(200),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
