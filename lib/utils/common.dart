import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Common {
  /// 节流 duration毫秒内只运行一次，若在 duration毫秒内重复触发，只有一次生效
  static throttle(Function func, [int duration = 2000]) {
    dynamic lastTime;
    return () {
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      if (lastTime == null || nowTime - lastTime! > duration) {
        func.call();
        lastTime = nowTime;
      }
    };
  }

  /// 防抖 duration毫秒后在执行该事件，若在 duration毫秒内被重复触发，则重新计时
  static debounce(Function func, [int duration = 2000]) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(Duration(milliseconds: duration), () {
        func.call();
        timer?.cancel();
      });
    };
  }

  /// 关闭键盘
  static void closeKeyboard() {
    FocusScope.of(Get.context!).unfocus();
  }
}
