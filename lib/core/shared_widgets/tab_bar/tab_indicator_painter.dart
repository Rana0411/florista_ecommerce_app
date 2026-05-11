import 'package:flutter/material.dart';

class TabIndicatorPainter extends CustomPainter {
  final Color color;

  TabIndicatorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height);

    path.lineTo(size.width - 6, size.height);

    path.lineTo(size.width, 0);

    path.lineTo(0, 0);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
