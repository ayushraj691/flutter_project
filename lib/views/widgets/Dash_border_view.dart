import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    // Define the rectangle with rounded corners
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    double totalLength = path.computeMetrics().first.length;

    double currentDistance = 0.0;
    while (currentDistance < totalLength) {
      // Calculate the start and end of the dash
      double startDistance = currentDistance;
      double endDistance = currentDistance + dashLength;

      PathMetrics metrics = path.computeMetrics();
      PathMetric metric = metrics.first;

      if (endDistance > totalLength) {
        endDistance = totalLength; // Ensure we don't go over the total length
      }

      // Create a new path for the dash
      Path dashPath = metric.extractPath(startDistance, endDistance);
      canvas.drawPath(dashPath, paint);

      currentDistance += dashLength + dashGap; // Move to the next dash
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
