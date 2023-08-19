import 'package:flutter/material.dart';

class SlideTransitionWidgt extends StatelessWidget {
  final Widget child;
  final AxisDirection direction;
  final Duration duration;

  /// 移动特效
  /// ```
  /// [direction] 移动方向
  /// [duration] 移动时间
  /// ``
  const SlideTransitionWidgt({
    super.key,
    required this.child,
    this.direction = AxisDirection.down,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return _SlideTransitionX(
          position: animation,
          direction: direction,
          child: child,
        );
      },
      child: child,
    );
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
