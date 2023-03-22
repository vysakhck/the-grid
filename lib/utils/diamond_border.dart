import 'package:flutter/material.dart';

class DiamondBorder extends ShapeBorder {
  const DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.centerLeft.dx, rect.centerLeft.dy)
      ..lineTo(rect.topCenter.dx, rect.topCenter.dy)
      ..lineTo(rect.centerRight.dx, rect.centerRight.dy)
      ..lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return const DiamondBorder();
  }
}
