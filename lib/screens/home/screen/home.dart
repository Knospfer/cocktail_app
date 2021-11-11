import 'package:cocktail_app/screens/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchCocktailList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              children: viewModel.cocktails
                  .map((c) => ListTile(title: Text(c.name)))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
