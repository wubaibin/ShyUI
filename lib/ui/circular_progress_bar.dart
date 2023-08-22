import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';

class CircularProgressBar extends StatefulWidget {
  final double progress;
  final double size;
  final Color backgroundColor;
  final List<Color>? gradientColors;
  final Color progressColor;
  final double strokeWidth;
  final Duration duration;
  final bool clockwise;
  final String? text;
  final TextStyle textStyle;

  /// 圆形进度条
  /// ```
  /// [progress] 范围从 0 到 100
  /// [size] 圆形进度条大小
  /// [backgroundColor] 背景颜色
  /// [progressColor] 进度颜色
  /// [strokeWidth] 线条宽度
  /// [duration] 动画时间
  /// [clockwise] 是否是顺时针
  /// ```
  const CircularProgressBar({
    super.key,
    required this.progress,
    this.size = 80,
    this.backgroundColor = Colors.white,
    this.gradientColors,
    this.progressColor = AppColor.themeColor,
    this.strokeWidth = 5.0,
    this.duration = const Duration(milliseconds: 500),
    this.clockwise = true,
    this.text,
    this.textStyle = const TextStyle(fontSize: 12, color: AppColor.primaryText),
  });

  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progress / 100,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void didUpdateWidget(CircularProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _progressAnimation = Tween<double>(
        begin: oldWidget.progress / 100,
        end: widget.progress / 100,
      ).animate(_animationController);
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: CustomPaint(
                  painter: _CircularProgressPainter(
                    progress: _progressAnimation.value,
                    backgroundColor: widget.backgroundColor,
                    progressColor: widget.progressColor,
                    strokeWidth: widget.strokeWidth,
                    clockwise: widget.clockwise,
                    gradientColors: widget.gradientColors,
                  ),
                ),
              ),
              if (widget.text != null && widget.text!.isNotEmpty)
                Center(child: Text(widget.text!, style: widget.textStyle)),
            ],
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final bool clockwise;
  final List<Color>? gradientColors;

  _CircularProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
    required this.clockwise,
    this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);
    final startAngle = clockwise ? -pi / 2 : (pi / 2) / 4;
    final endAngle = 2 * pi * (progress.clamp(0.0, 1.0));
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    if (gradientColors != null && gradientColors!.isNotEmpty) {
      progressPaint.shader = SweepGradient(
        colors: gradientColors!,
        startAngle: startAngle,
        endAngle: endAngle,
        transform: GradientRotation(startAngle - pi * 0.02),
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      progressPaint.color = progressColor;
    }
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      endAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        backgroundColor != oldDelegate.backgroundColor ||
        progressColor != oldDelegate.progressColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
