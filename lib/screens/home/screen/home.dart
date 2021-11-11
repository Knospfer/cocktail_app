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
  void didChangeDependencies() {
    Provider.of<HomeViewModel>(context).fetchCocktailList();
    super.didChangeDependencies();
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
