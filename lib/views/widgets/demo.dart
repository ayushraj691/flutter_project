import 'package:flutter/material.dart';
import 'dart:math';

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw dashed circle
    final double radius = size.width / 2 - strokeWidth / 2; // Adjust radius to fit within the circle
    final Offset center = Offset(size.width / 2, size.height / 2); // Center of the circle

    double totalCircumference = 2 * pi * radius;
    double dashAndGapLength = dashLength + dashGap;
    double currentDistance = 0.0;

    while (currentDistance < totalCircumference) {
      final startAngle = (currentDistance / totalCircumference) * 2 * pi;
      final endAngle = ((currentDistance + dashLength) / totalCircumference) * 2 * pi;

      final startPoint = Offset(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );

      final endPoint = Offset(
        center.dx + radius * cos(endAngle),
        center.dy + radius * sin(endAngle),
      );

      canvas.drawLine(startPoint, endPoint, paint);
      currentDistance += dashAndGapLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}