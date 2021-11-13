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
      title: Text(_title),
      leading: Radio<AlcoholPresence>(
        value: AlcoholPresence.present,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
