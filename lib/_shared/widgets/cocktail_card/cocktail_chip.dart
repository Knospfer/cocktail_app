import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CocktailChip extends StatelessWidget {
  late final String _label;
  late final Color _color;

  CocktailChip({Key? key, required CocktailEntity cocktail}) : super(key: key) {
    switch (cocktail.alcoholPresence) {
      case AlcoholPresence.present:
        _label = "Alcoholic";
        _color = Colors.red;
        break;
      case AlcoholPresence.absent:
        _label = "Analcoholic";
        _color = Colors.green;
        break;
      case AlcoholPresence.optional:
        _label = "Optional";
        _color = Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _label,
        style: const ExtraSmallTextStyle().copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
      backgroundColor: _color,
    );
  }
}
