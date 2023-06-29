import 'package:flutter/material.dart';

class MySeparatorLine extends CustomPainter {
  final Color lineColor;
  final double width;
  final double height;

  MySeparatorLine({required this.lineColor, required this.width, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = this.lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = height
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, 0.0), Offset(width, 0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
