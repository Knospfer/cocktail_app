import 'package:cocktail_app/core/theme/app_theme_data.dart';
import 'package:cocktail_app/screens/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appThemeData,
      home: const HomeScreen(),
    );
  }
}
