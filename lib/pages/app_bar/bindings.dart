import 'package:get/get.dart';

import 'controller.dart';

class AppBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppBarController>(() => AppBarController());
  }
}
