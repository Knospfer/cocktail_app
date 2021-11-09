import 'package:cocktail_app/screens/favourites.dart';
import 'package:cocktail_app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_shared/widgets/circle_indicator.dart';

class AppRootScreen extends StatelessWidget {
  const AppRootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              HomeScreen(),
              FavouritesScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.pink,
            child: const Icon(Icons.qr_code),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const TabBar(
            indicator: CircleTabIndicator(color: Colors.white, radius: 3),
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.favorite)),
            ],
          ),
        ),
      ),
    );
  }
}
