import 'package:flutter/material.dart';

class MySeparatorLine extends CustomPainter {
  final Color lineColor;
  final double width;

  MySeparatorLine({this.lineColor, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = this.lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 0.1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, 0.0), Offset(width, 0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
