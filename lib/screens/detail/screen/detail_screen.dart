import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/favourite_button.dart';
import 'package:cocktail_app/screens/detail/view_model/detail_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, //TODO theme
        elevation: 0,
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
                  Provider.of<DetailViewModel>(context, listen: false)
                      .toggleFavourite(widget.cocktail);
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: screenSize.height / 2,
            width: screenSize.width,
            child: FadeInImage.assetNetwork(
              fadeInDuration: const Duration(milliseconds: 200),
              placeholder: 'assets/placeholder.png',
              image: widget.cocktail.image ?? "",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox.expand(
              child: DraggableScrollableSheet(
            //TODO estrai widget
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  clipBehavior: Clip.hardEdge,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                    color: Colors.grey.shade800,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.cocktail.name,
                        style: const TextStyle(
                          //TODO generalizza
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                      ), //TODO generalizza
                      Text(
                        widget.cocktail.category,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18.0,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      Text(
                        widget.cocktail.instructions ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
