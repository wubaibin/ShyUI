import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';

class TabIndicator extends Decoration {
  final double width;
  final double height;
  final Color color;
  final double radius;
  final double bottom;

  /// TabBar 自定义indicator
  /// ```
  /// [width] 宽度
  /// [height] 高度
  /// [color] 背景颜色
  /// [radius] 圆角
  /// [bottom] 距离底部距离
  /// ```
  const TabIndicator({
    this.width = 30,
    this.height = 4,
    this.color = AppColor.themeColor,
    this.radius = 10,
    this.bottom = 0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _LinePinter(width, height, color, radius, bottom);
  }
}

class _LinePinter extends BoxPainter {
  final double width;
  final double height;
  final Color color;
  final double radius;
  final double bottom;

  _LinePinter(
    this.width,
    this.height,
    this.color,
    this.radius,
    this.bottom,
  );

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    final centerX = configuration.size!.width / 2 + offset.dx;

    final bottomValue = configuration.size!.height - bottom;

    final halfWidth = width / 2;

    canvas.drawRRect(
      RRect.fromLTRBR(
        centerX - halfWidth,
        bottomValue - height,
        centerX + halfWidth,
        bottomValue,
        Radius.circular(radius),
      ),
      paint,
    );
  }
}
