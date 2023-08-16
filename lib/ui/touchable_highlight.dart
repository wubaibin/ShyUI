import 'package:flutter/material.dart';

class TouchableHighlight extends StatefulWidget {
  final Widget? child;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;
  final Color bgColor;
  final LinearGradient? gradient;
  final double activeOpacity;
  final Color activeBgColor;
  final Function? onPress;

  /// 当按下的时候，封装的视图的不透明度会降低使得视图变暗
  /// ```
  /// [child] 子组件
  /// [width] 容器的宽度
  /// [height] 容器的高度
  /// [padding] 容器的padding
  /// [borderRadius] 容器的圆角
  /// [bgColor] 设置容器背景颜色
  /// [gradient] 设置容器背景颜色渐变
  /// [activeBgColor] 容器被按下的不透明颜色
  /// [activeOpacity] 容器被按下的不透明颜色的透明度
  /// [onPress] 按下事件
  /// ```
  const TouchableHighlight({
    super.key,
    this.child,
    required this.width,
    required this.height,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.bgColor = Colors.white,
    this.gradient,
    this.activeOpacity = 0.2,
    this.activeBgColor = const Color(0xFF333333),
    this.onPress,
  });

  @override
  State<TouchableHighlight> createState() => _TouchableHighlightState();
}

class _TouchableHighlightState extends State<TouchableHighlight> {
  bool isTap = false;
  late double containerWidth;
  final GlobalKey container = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) {
          widget.onPress!();
        }
      },
      onTapDown: (details) {
        setState(() {
          isTap = true;
          containerWidth =
              container.currentContext?.size?.width ?? widget.width;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTap = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isTap = false;
        });
      },
      child: Stack(
        children: [
          Container(
            key: container,
            height: widget.height,
            padding: widget.padding,
            constraints: BoxConstraints(
              minWidth: widget.width,
            ),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              gradient: widget.gradient,
              color: widget.bgColor,
            ),
            child: widget.child,
          ),
          isTap
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: Opacity(
                    opacity: widget.activeOpacity,
                    child: Container(
                      width: containerWidth,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.activeBgColor,
                        borderRadius: widget.borderRadius,
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}
