import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/screens/search/widgets/alcohol_presence_radio_group/alcohol_presence_radio_button.dart';
import 'package:flutter/material.dart';

class AlcoholPresenceRadioGroup extends StatelessWidget {
  final AlcoholPresence groupValue;
  final void Function(AlcoholPresence? value) onChanged;

  const AlcoholPresenceRadioGroup({
    Key? key,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AlcoholPresenceRadioButton(
          value: AlcoholPresence.present,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        AlcoholPresenceRadioButton(
          value: AlcoholPresence.absent,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        AlcoholPresenceRadioButton(
          value: AlcoholPresence.optional,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
