import 'dart:async';

import 'package:shy_ui/ui/toast.dart';
import 'package:get/get.dart';

import 'index.dart';

class ToastController extends GetxController {
  ToastController();

  final state = ToastState();

  void textTap(bool maskClose) {
    $toast.showToast(title: "这是文字提示", maskClose: maskClose);
  }

  void textOtherTap() {
    $toast.showToast(title: "这是文字提示", mask: false);
  }

  void loadingTap() {
    $toast.showLoading(title: "加载中...");
    Timer.periodic(const Duration(seconds: 3), (timer) {
      $toast.hideLoading();
      timer.cancel();
    });
  }

  void iconTap(String icon) {
    $toast.showToast(title: "这是文字提示", icon: icon);
  }
}
