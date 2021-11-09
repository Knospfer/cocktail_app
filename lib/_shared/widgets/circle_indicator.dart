import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final double radius;
  final Color color;

  const CircleTabIndicator({required this.radius, required this.color});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _CirclePainter(radius, color);
}

class _CirclePainter extends BoxPainter {
  final double radius;
  final Color color;
  late final Paint _paint;

  _CirclePainter(this.radius, this.color)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size;
    if (size == null) return;

    final circleCenter =
        offset + Offset(size.width / 2, size.height - radius - 5);
    canvas.drawCircle(circleCenter, radius, _paint);
  }
}
