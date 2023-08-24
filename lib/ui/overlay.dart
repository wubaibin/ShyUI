import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/utils/screen.dart';
import 'package:get/get.dart';

class $overlay {
  static OverlayEntry? _overlayEntry;

  /// 展示遮罩层
  static void show() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {},
            child: Container(
              width: Screen.width,
              height: Screen.height,
              color: AppColor.maskBgColor,
              padding: const EdgeInsets.symmetric(horizontal: 35),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                child: Container(),
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
