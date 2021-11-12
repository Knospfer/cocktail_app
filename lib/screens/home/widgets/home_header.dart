import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(padding: EdgeInsets.only(bottom: 80)),
        Text(
          "Hi",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 10)),
        Text(
          "What would you like \nto drink tonight?",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }
}
