import 'package:cocktail_app/_core/routes/tab_routes.dart';
import 'package:cocktail_app/_shared/widgets/app_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRootScreen extends StatelessWidget {
  const AppRootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = TabRoutes.buildTabRoutes();

    return DefaultTabController(
      length: routes.length,
      child: Scaffold(
        extendBody: true,
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: routes,
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blueGrey,
            child: const Icon(Icons.qr_code),
            elevation: 1,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const AppTabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.favorite)),
          ],
        ),
      ),
    );
  }
}
