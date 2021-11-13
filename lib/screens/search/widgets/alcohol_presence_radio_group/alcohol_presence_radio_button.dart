import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlcoholPresenceRadioButton extends StatelessWidget {
  final AlcoholPresence value;
  final AlcoholPresence groupValue;
  final void Function(AlcoholPresence? value) onChanged;
  late final String _title;

  AlcoholPresenceRadioButton({
    Key? key,
    required this.groupValue,
    required this.onChanged,
    required this.value,
  }) : super(key: key) {
    switch (value) {
      case AlcoholPresence.present:
        _title = "Yes";
        break;
      case AlcoholPresence.absent:
        _title = "No";
        break;
      case AlcoholPresence.optional:
        _title = "Optional";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 4),
      title: Text(
        _title,
        style: const TextStyle(color: ColorPalette.white),
      ),
      leading: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white30),
        child: Radio<AlcoholPresence>(
          activeColor: ColorPalette.white,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
