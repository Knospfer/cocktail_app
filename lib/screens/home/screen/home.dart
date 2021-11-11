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
      body: Container(
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
        ),
        alignment: Alignment.center,
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text(
                  "Hi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Text(
                  "What would you like \nto drink tonight?",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ...viewModel.cocktails
                    .map(
                      (c) => Container(
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(c.image ?? ""),
                          ),
                        ),
                        child: Container(
                          color: Colors.black26,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                c.category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
