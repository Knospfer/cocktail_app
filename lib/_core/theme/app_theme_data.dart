import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  scaffoldBackgroundColor: ColorPalette.black,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: ColorPalette.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: ColorPalette.white)),
);
