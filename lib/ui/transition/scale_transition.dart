import 'package:flutter/material.dart';

class ScaleTransitionWidget extends StatefulWidget {
  final Widget? child;
  final double scale;
  final int duration;
  final Function? onPress;

  /// 区域按下缩小,松开恢复
  /// ```
  /// [child] 子组件
  /// [scale] 缩小幅度
  /// [duration] 过渡时间
  /// ```
  const ScaleTransitionWidget({
    super.key,
    required this.child,
    this.scale = 0.1,
    this.duration = 350,
    this.onPress,
  });

  @override
  State<ScaleTransitionWidget> createState() => _ScaleTransitionWidgetState();
}

class _ScaleTransitionWidgetState extends State<ScaleTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      lowerBound: 0.0,
      upperBound: widget.scale,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    if (widget.scale == 0) {
      return;
    }
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    if (widget.scale == 0) {
      return;
    }
    _controller.reverse();
  }

  void _tapCancel() {
    if (widget.scale == 0) {
      return;
    }
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) {
          widget.onPress!();
        }
      },
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: widget.scale == 0
          ? widget.child
          : Transform.scale(
              scale: 1 - _controller.value,
              child: widget.child,
            ),
    );
  }
}
