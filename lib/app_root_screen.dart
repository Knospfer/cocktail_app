import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_core/routes/tab_routes.dart';
import 'package:cocktail_app/_shared/widgets/app_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRootScreen extends StatefulWidget {
  const AppRootScreen({Key? key}) : super(key: key);

  @override
  State<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends State<AppRootScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<Widget> _routes;
  int _index = 0;

  @override
  void initState() {
    _routes = TabRoutes.buildTabRoutes();
    _tabController = TabController(length: _routes.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _handleTabSelection() {
    setState(() {
      _index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _routes.length,
      child: Scaffold(
        extendBody: true,
        body: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: _routes,
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.qrScanner);
            },
            backgroundColor: ColorPalette.deepRed,
            child: Theme(
              data: ThemeData(
                iconTheme: const IconThemeData(color: ColorPalette.white),
              ),
              child: const Icon(Icons.qr_code),
            ),
            elevation: 1,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppTabBar(
          tabController: _tabController,
          tabs: [
            Tab(
                icon: Icon(
              Icons.home,
              color: _index == 0
                  ? ColorPalette.deepRed
                  : ColorPalette.black.withAlpha(120),
            )),
            Tab(
                icon: Icon(
              Icons.favorite,
              color: _index == 1
                  ? ColorPalette.deepRed
                  : ColorPalette.black.withAlpha(120),
            )),
          ],
        ),
      ),
    );
  }
}
