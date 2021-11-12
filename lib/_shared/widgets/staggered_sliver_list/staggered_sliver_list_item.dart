import 'package:flutter/cupertino.dart';

class StaggereSliverListItem extends StatelessWidget {
  final Widget child;
  final Animation animation;

  const StaggereSliverListItem({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(Tween(
        begin: const Offset(1, 0),
        end: Offset.zero,
      )),
      child: child,
    );
  }
}
