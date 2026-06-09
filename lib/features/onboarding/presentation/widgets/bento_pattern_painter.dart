import 'package:flutter/material.dart';

/// مخصص لرسم النقاط الشبكية خلف الصورة التوضيحية
class BentoPatternPainter extends CustomPainter {
  const BentoPatternPainter({required this.dotColor});
  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    const double spacing = 24.0;
    const double radius = 1.2;

    for (double x = 0.0; x < size.width; x += spacing) {
      for (double y = 0.0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BentoPatternPainter oldDelegate) =>
      oldDelegate.dotColor != dotColor;
}
