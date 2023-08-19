import 'package:get/get.dart';

import 'controller.dart';

class ToastBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToastController>(() => ToastController());
  }
}
