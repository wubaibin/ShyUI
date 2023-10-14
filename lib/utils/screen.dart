import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shy_ui/config/index.dart';

enum SafeAreaType { top, right, bottom, left }

class Screen {
  static MediaQueryData get mediaQuery => MediaQuery.of(Get.context!);

  /// 获取屏幕的宽度
  static double get width => mediaQuery.size.width;

  /// 获取屏幕的高度
  static double get height => mediaQuery.size.height;

  /// 获取除去上下安全距离和navBar的屏幕高度
  static double get stageHeight => height - bottomBar - appBarHeight;

  /// 获取顶部安全距离
  static double get statusBar => mediaQuery.padding.top;

  /// 获取底部安全距离
  static double get bottomBar => mediaQuery.padding.bottom;

  /// 获取底部导航栏高度
  static double get bottomBarHeight => Config.bottomAppBarHeight + bottomBar;

  /// 获取顶部导航栏高度
  static double get appBarHeight => Config.appBarHeight + statusBar;

  /// 获取安全距离
  static double safeArea(SafeAreaType type) {
    if (type == SafeAreaType.top) {
      return mediaQuery.padding.top;
    }
    if (type == SafeAreaType.right) {
      return mediaQuery.padding.right;
    }
    if (type == SafeAreaType.bottom) {
      return mediaQuery.padding.bottom;
    }
    return mediaQuery.padding.left;
  }
}
