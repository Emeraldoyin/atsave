import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double radiusTopLeft = 0.r; // Top left corner radius
    double radiusTopRight = 40.0.r; // Top right corner radius
    double radiusBottomLeft = 30.0; // Bottom left corner radius
    double radiusBottomRight = 10.0.r; // Bottom right corner radius

    return Path()
      ..moveTo(rect.left + radiusTopLeft, rect.top) // Top left corner
      ..lineTo(rect.width - radiusTopRight, rect.top) // Top right corner
      ..quadraticBezierTo(rect.width, rect.top, rect.width,
          rect.top + radiusTopRight) // Top right curve
      ..lineTo(
          rect.width, rect.height - radiusBottomRight) // Bottom right corner
      ..quadraticBezierTo(rect.width, rect.height,
          rect.width - radiusBottomRight, rect.height) // Bottom right curve
      ..lineTo(rect.left + radiusBottomLeft, rect.height) // Bottom left corner
      ..quadraticBezierTo(rect.left, rect.height, rect.left,
          rect.height - radiusBottomLeft) // Bottom left curve
      ..lineTo(rect.left, rect.top + radiusTopLeft) // Top left corner
      ..quadraticBezierTo(rect.left, rect.top, rect.left + radiusTopLeft,
          rect.top) // Top left curve
      ..close(); // Close the path
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}
