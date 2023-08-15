import 'package:flutter/material.dart';

class NavigatorRoute extends PopupRoute {
  final Widget child;
  final int duration;
  final Color bgColor;

  NavigatorRoute({
    required this.bgColor,
    required this.duration,
    required this.child,
  });

  // 背景颜色
  @override
  Color? get barrierColor => bgColor;

  // 淡入淡出动画过渡时间
  @override
  Duration get transitionDuration => Duration(milliseconds: duration);

  // 点背景是否关闭
  @override
  bool get barrierDismissible => true;

  // 盲人
  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }
}
