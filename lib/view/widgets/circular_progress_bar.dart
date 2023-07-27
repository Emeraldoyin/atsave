import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final double progressPercentage;

  const CircularProgressBar({Key? key, required this.progressPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: _CircularProgressBarPainter(progressPercentage),
    );
  }
}

class _CircularProgressBarPainter extends CustomPainter {
  final double progressPercentage;

  _CircularProgressBarPainter(this.progressPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    const double strokeWidth = 25;

    final backgroundPaint = Paint()
      ..color = const Color.fromARGB(255, 240, 236,
          236) // Change the color as per your preference for the background
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = Colors
          .blue // Change the color as per your preference for the progress
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw the background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the progress arc
    final progressAngle = 2 * pi * (progressPercentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
