import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  final String title;
  final String content;

  const DataItem({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ColorPalette.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const VerticalPadding(padding: 10),
        Text(
          content,
          style:
              TextStyle(color: ColorPalette.white.withAlpha(200), fontSize: 16),
        ),
        Divider(
          color: ColorPalette.white.withAlpha(100),
        ),
      ],
    );
  }
}
