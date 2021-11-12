import 'package:cocktail_app/_domain/cocktail/domain/cocktail_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final CocktailEntity cocktail;

  const DetailScreen({Key? key, required this.cocktail}) : super(key: key);

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
              onPressed: () {},
              icon: const Icon(
                Icons.ios_share_outlined,
              ), //TODO icona per ios e per android
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
              ), //TODO pieno o vuoto se è preferito
            )
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
                image: cocktail.image ?? "",
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
                          cocktail.name,
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
                          cocktail.category,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18.0,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                        Text(
                          cocktail.instructions ?? "",
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
        ));
  }
}
