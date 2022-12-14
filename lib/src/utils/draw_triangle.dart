import 'package:flutter/material.dart';


// Отрисовка разноцветного треуольника
class DrawTriangle extends CustomPainter {
  int color;

  DrawTriangle({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width, size.height * 0.40);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = Color(color));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

