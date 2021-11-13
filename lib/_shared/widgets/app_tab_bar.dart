import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circle_indicator.dart';

class AppTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? tabController;

  const AppTabBar({
    Key? key,
    required this.tabs,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalMarginWidth = MediaQuery.of(context).size.width / 5;

    return Container(
      margin: EdgeInsets.only(
        left: horizontalMarginWidth,
        right: horizontalMarginWidth,
        bottom: 14,
      ),
      padding: const EdgeInsets.symmetric(vertical: 1),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: ColorPalette.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            offset: Offset(0.0, 1.0),
            color: Colors.black12,
          )
        ],
      ),
      child: TabBar(
        controller: tabController,
        tabs: tabs,
        indicator:
            const CircleTabIndicator(color: ColorPalette.deepRed, radius: 3),
      ),
    );
  }
}
