import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/transition/index.dart';
import 'package:flutter_face/utils/screen.dart';
import 'package:get/get.dart';

class $overlay {
  static OverlayEntry? _overlayEntry;

  /// 展示遮罩层
  /// ```
  /// [name] 动画名称
  /// [duration] 动画过渡时间
  /// [child] 子组件
  /// ```
  static void show({
    TransitionType name = TransitionType.slideUp,
    int duration = 500,
    bool showTransition = false,
    required Widget child,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              hide();
            },
            child: Container(
              width: Screen.width,
              height: Screen.height,
              color: AppColor.maskBgColor,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                child: showTransition
                    ? TransitionContainer(
                        name: name,
                        duration: duration,
                        child: child,
                      )
                    : child,
              ),
            ),
          ),
        );
      },
    );
    Navigator.of(Get.context!).overlay?.insert(_overlayEntry!);
  }

  /// 关闭 遮罩层
  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}

class TransitionContainer extends StatefulWidget {
  final TransitionType name;
  final Widget child;
  final int duration;

  const TransitionContainer({
    super.key,
    required this.name,
    required this.child,
    required this.duration,
  });

  @override
  State<TransitionContainer> createState() => _TransitionContainerState();
}

class _TransitionContainerState extends State<TransitionContainer> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        show = true;
      });
      timer.cancel();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TransitionWidget(
      show: show,
      duration: widget.duration,
      name: widget.name,
      child: widget.child,
    );
  }
}
