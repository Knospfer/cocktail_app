import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/screen_header.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/view_model/main_screen_scaffold_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Use this widget to create the basic layout
///for screens similar to [HomeScreen]
///
///Add [MainScreenScaffoldViewModel] to ChangeNotifierPRovider
///of the Screen using this widget in [Routes] or [TabRoutes]
class MainScreenScaffold extends StatefulWidget {
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
  State<MainScreenScaffold> createState() => MainScreenScaffoldState();
}

class MainScreenScaffoldState extends State<MainScreenScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: ColorPalette.black,
                actions: [
                  IconButton(
                    onPressed: widget.onSearchPressed,
                    splashRadius: 20,
                    icon: const Icon(Icons.search),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.bottomLeft,
                    child: ScreenHeader(
                      title: widget.title,
                      subtitle: widget.subtitle,
                    ),
                  ),
                ),
                title: const Text("Cocktailz"),
              ),
              ...widget.children,
            ],
          ),
          Consumer<MainScreenScaffoldViewModel>(
              builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Container(
                color: ColorPalette.black.withAlpha(100),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}
