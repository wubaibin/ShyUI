import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';

enum DashedLineDirection {
  horizontal,
  vertical,
}

class DashedLine extends StatelessWidget {
  final double width;
  final double height;
  final DashedLineDirection direction;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  /// 虚线
  /// ```
  /// [width] 宽度
  /// [height] 高度
  /// [color] 虚线的颜色
  /// [direction] 虚线方向
  /// [dashWidth] 虚线的宽度
  /// [dashSpace] 虚线的间距
  /// ```
  const DashedLine({
    super.key,
    this.width = double.infinity,
    this.height = 1,
    this.direction = DashedLineDirection.horizontal,
    this.color = AppColor.placeholderText,
    this.dashWidth = 4,
    this.dashSpace = 4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _DashedPainter(
        color,
        dashWidth,
        dashSpace,
        direction,
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final DashedLineDirection direction;

  _DashedPainter(
    this.color,
    this.dashWidth,
    this.dashSpace,
    this.direction,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth =
          direction == DashedLineDirection.horizontal ? size.height : size.width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double start = 0;
    double end =
        direction == DashedLineDirection.horizontal ? size.width : size.height;
    while (start < end) {
      if (direction == DashedLineDirection.horizontal) {
        canvas.drawLine(
          Offset(start, 0),
          Offset(start + dashWidth, 0),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(0, start),
          Offset(0, start + dashWidth),
          paint,
        );
      }
      start += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
