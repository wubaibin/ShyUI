import 'package:flutter/material.dart';

class SlideTransitionWidgt extends StatelessWidget {
  final bool show;
  final Widget child;
  final AxisDirection direction;
  final int duration;

  /// 移动特效
  /// ```
  /// [show] 是否展示
  /// [child] 子组件
  /// [direction] 移动方向
  /// [duration] 移动时间
  /// ``
  const SlideTransitionWidgt({
    super.key,
    required this.show,
    required this.child,
    this.direction = AxisDirection.down,
    this.duration = 500,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return _SlideTransitionX(
          position: animation,
          direction: show ? direction : _leaveDirection(),
          child: child,
        );
      },
      child: show ? child : const SizedBox(),
    );
  }

  AxisDirection _leaveDirection() {
    switch (direction) {
      case AxisDirection.down:
        return AxisDirection.up;
      case AxisDirection.up:
        return AxisDirection.down;
      case AxisDirection.left:
        return AxisDirection.right;
      default:
        return AxisDirection.left;
    }
  }
}

class _SlideTransitionX extends AnimatedWidget {
  final Widget child;

  final AxisDirection direction;

  late final Tween<Offset> _tween;

  _SlideTransitionX({
    Key? key,
    required Animation<double> position,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: true,
      child: child,
    );
  }
}
