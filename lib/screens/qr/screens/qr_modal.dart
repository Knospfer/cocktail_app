import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrModalScreen extends StatelessWidget {
  final CocktailEntity cocktail;

  const QrModalScreen({Key? key, required this.cocktail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: screenSize.width * 0.8,
          width: screenSize.width * 0.8,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: ColorPalette.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Share me with you friends!",
                style: const MediumTextStyle().copyWith(
                  color: ColorPalette.black,
                ),
              ),
              const VerticalPadding(padding: 4),
              QrImage(
                data: cocktail.id,
                version: QrVersions.auto,
                size: screenSize.width * 0.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
