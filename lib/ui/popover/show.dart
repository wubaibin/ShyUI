import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shy_ui/ui/navigator_route.dart';

class ShowPopover {
  static final _context = Get.context!;

  static void show({
    required Widget child,
    required Widget dotChild,
    Function? onBeforeClose,
    int duration = 300,
  }) {
    Navigator.push(
      _context,
      NavigatorRoute(
        bgColor: Colors.transparent,
        duration: duration,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              if (onBeforeClose != null) {
                onBeforeClose();
              }
              hide();
            },
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.transparent,
                ),
                child,
                dotChild,
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hide() {
    Navigator.of(_context).pop();
  }
}
