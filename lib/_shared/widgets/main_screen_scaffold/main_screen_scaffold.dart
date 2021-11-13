import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/screen_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Use this widget to create the basic layout
///for screens similar to [HomeScreen]
class MainScreenScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final void Function() onSearchPressed;

  const MainScreenScaffold({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            
            actions: [
              IconButton(
                onPressed: onSearchPressed,
                splashRadius: 20,
                icon: const Icon(Icons.search),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomLeft,
                child: ScreenHeader(
                  title: title,
                  subtitle: subtitle,
                ),
              ),
            ),
            title: const Text("Cocktailz"),
          ),
          ...children,
        ],
      ),
    );
  }
}
