import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const ScreenHeader({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const ExtarLargeTextStyle(),
        ),
        const VerticalPadding(padding: 10),
        Text(
          subtitle,
          style: const LargeTextStyle().copyWith(fontSize: 26),
        ),
        const VerticalPadding(padding: 20),
      ],
    );
  }
}
