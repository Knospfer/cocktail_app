import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/favourite_button.dart';
import 'package:cocktail_app/screens/detail/view_model/detail_view_model.dart';
import 'package:cocktail_app/screens/detail/widgets/data_container/data_container.dart';
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
                  icon: const Icon(Icons.ios_share_outlined),
                ),
                Consumer<DetailViewModel>(
                  builder: (context, viewModel, child) {
                    return FavouriteButton(
                      isFavourite: widget.cocktail.favourite,
                      onFavouriteTapped: () {
                        fetchViewModel<DetailViewModel>(context)
                            .toggle(widget.cocktail);
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
                child: DataContainer(cocktail: widget.cocktail),
              ),
            )
          ],
        ),
      ),
    );
  }
}
