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
        const Padding(padding: EdgeInsets.only(bottom: 80)),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)), //TODO generalizza
        Text(
          subtitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 26), //TODO generalizza
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }
}
