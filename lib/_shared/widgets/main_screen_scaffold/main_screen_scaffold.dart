import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/screen_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Use this widget to create the basic layout
///for screens similar to [HomeScreen]
class MainScreenScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const MainScreenScaffold({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: ScreenHeader(
                title: title,
                subtitle: subtitle,
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
