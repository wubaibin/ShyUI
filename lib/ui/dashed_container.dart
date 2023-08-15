import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';

class DashedContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final BorderRadius borderRadius;

  /// 虚线容器
  /// ```
  /// [strokeWidth] 虚线的边框宽度
  /// [color] 虚线的颜色
  /// [dashWidth] 虚线中每个实线段的长度
  /// [dashSpace] 虚线中实线和空白之间的间隔
  /// ```
  const DashedContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.color = AppColor.placeholderText,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedContainerPainter(
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DashedContainerPainter extends CustomPainter {
  final double strokeWidth;
  final double dashSpace;
  final double dashWidth;
  final Color color;
  final BorderRadius borderRadius;

  _DashedContainerPainter({
    required this.strokeWidth,
    required this.dashSpace,
    required this.dashWidth,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect rrect = borderRadius.toRRect(rect);

    Path path = Path()
      ..addRRect(rrect)
      ..close();

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0;
      bool draw = true;

      while (distance < pathMetric.length) {
        double length = draw ? dashWidth : dashSpace;
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + length),
          paint,
        );
        distance += dashWidth + dashSpace;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is _DashedContainerPainter) {
      return strokeWidth != oldDelegate.strokeWidth ||
          color != oldDelegate.color ||
          borderRadius != oldDelegate.borderRadius;
    }
    return false;
  }
}
