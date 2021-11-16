import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:flutter/cupertino.dart';

import 'data_item.dart';

class DataContainer extends StatelessWidget {
  final CocktailEntity cocktail;

  const DataContainer({Key? key, required this.cocktail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DataItem(title: "Name", content: cocktail.name),
        DataItem(title: "Category", content: cocktail.category),
        DataItem(title: "Alcoholic", content: _alcoholicString()),
        DataItem(
          title: "Instruction",
          content: cocktail.instructions ?? "Not present",
        ),
        Text(
          "Ingredients",
          style: const MediumTextStyle().copyWith(fontWeight: FontWeight.bold),
        ),
        const VerticalPadding(padding: 10),
        ...cocktail.ingredients.map(
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              i ?? "",
              style: const ExtraSmallTextStyle().copyWith(
                color: ColorPalette.white.withAlpha(200),
              ),
            ),
          ),
        )
      ],
    );
  }

  String _alcoholicString() {
    switch (cocktail.alcoholPresence) {
      case AlcoholPresence.present:
        return "Yes";
      case AlcoholPresence.absent:
        return "No";
      case AlcoholPresence.optional:
        return "Optional";
      default:
        return "Unknown";
    }
  }
}
