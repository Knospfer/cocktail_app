import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  scaffoldBackgroundColor: ColorPalette.black,
  primarySwatch: Colors.grey,
  appBarTheme: AppBarTheme(
      titleTextStyle: const ExtraSmallTextStyle().copyWith(
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: ColorPalette.white)),
);
