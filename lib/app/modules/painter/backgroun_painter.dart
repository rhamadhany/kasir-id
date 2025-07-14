import 'package:flutter/material.dart';

class BackgrounPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, kToolbarHeight / 2)
      ..lineTo(width, kToolbarHeight / 2)
      ..lineTo(width, height * 0.5)
      ..lineTo(0, height * 0.05)
      ..moveTo(0, height)
      ..lineTo(0, height * 0.55)
      ..lineTo(width, height * 0.95)
      ..lineTo(width, height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgrounPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgrounPainter oldDelegate) => false;
}
