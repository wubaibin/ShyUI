import 'package:flutter/material.dart';
import 'package:shy_ui/ui/transition/fade_transition.dart';
import 'package:shy_ui/ui/transition/slide_transition.dart';

enum TransitionType {
  /// 淡入
  fade,

  /// 上滑淡入
  fadeUp,

  /// 下滑淡入
  fadeDown,

  /// 左滑淡入

  fadeLeft,

  /// 右滑淡入
  fadeRight,

  /// 上滑进入
  slideUp,

  /// 下滑进入
  slideDown,

  /// 左滑进入

  slideLeft,

  /// 右滑进入
  slideRight
}

class TransitionWidget extends StatelessWidget {
  final TransitionType name;
  final bool show;
  final Widget child;
  final int duration;
  final Curve curve;

  /// 动画
  /// ```
  /// [name] 动画名称
  /// [show] 是否展示
  /// [child] 子组件
  /// [duration] 动画过渡时间
  /// [curve] 动画过度效果
  /// ```
  const TransitionWidget({
    super.key,
    this.name = TransitionType.slideLeft,
    required this.show,
    required this.child,
    this.duration = 1000,
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = show ? 1.0 : 0.0;

    switch (name) {
      case TransitionType.slideUp:
        return SlideTransitionWidgt(
          show: show,
          direction: AxisDirection.up,
          duration: duration,
          child: child,
        );
      case TransitionType.slideDown:
        return SlideTransitionWidgt(
          show: show,
          direction: AxisDirection.down,
          duration: duration,
          child: child,
        );
      case TransitionType.slideLeft:
        return SlideTransitionWidgt(
          show: show,
          direction: AxisDirection.left,
          duration: duration,
          child: child,
        );
      case TransitionType.fadeUp:
        return AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: duration),
          curve: curve,
          child: SlideTransitionWidgt(
            show: show,
            direction: AxisDirection.up,
            duration: duration,
            child: child,
          ),
        );
      case TransitionType.fadeDown:
        return AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: duration),
          curve: curve,
          child: SlideTransitionWidgt(
            show: show,
            direction: AxisDirection.down,
            duration: duration,
            child: child,
          ),
        );
      case TransitionType.fadeRight:
        return AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: duration),
          curve: curve,
          child: SlideTransitionWidgt(
            show: show,
            direction: AxisDirection.right,
            duration: duration,
            child: child,
          ),
        );
      case TransitionType.fadeLeft:
        return AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: duration),
          curve: curve,
          child: SlideTransitionWidgt(
            show: show,
            direction: AxisDirection.left,
            duration: duration,
            child: child,
          ),
        );
      default:
        return FadeTransitionWidget(
          show: show,
          duration: duration,
          child: child,
        );
    }
  }
}
