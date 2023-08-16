import 'package:get/get.dart';

import 'controller.dart';

class IconBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IconController>(() => IconController());
  }
}
