import 'package:flutter/cupertino.dart';

class VerticalPadding extends StatelessWidget {
  final double padding;

  const VerticalPadding({Key? key, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: padding));
  }
}
