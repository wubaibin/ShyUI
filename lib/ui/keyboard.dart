import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  final Widget child;
  final Function? onTap;

  /// 点击空白，关闭输入框
  const KeyboardWidget({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
        if (onTap != null) {
          onTap!();
        }
      },
      child: child,
    );
  }
}
