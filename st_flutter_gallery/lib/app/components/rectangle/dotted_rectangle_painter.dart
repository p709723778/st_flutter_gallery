import 'package:flutter/material.dart';
import 'package:getwidget/components/border/gf_dashed_border.dart';

class DottedRectanglePainter extends CustomPainter {
  DottedRectanglePainter(this.points, {this.color});
  final List<Offset> points;
  final Color? color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    const dashWidth = 1.0;
    const dashSpace = 5.0;
    final path = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy)
      ..lineTo(points[3].dx, points[3].dy)
      ..close();

    final dashPath1 = dashPath(
      path,
      dashedarray: CircularIntervalList<double>([dashWidth, dashSpace]),
    );
    canvas.drawPath(dashPath1!, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
