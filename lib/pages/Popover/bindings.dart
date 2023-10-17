import 'package:get/get.dart';

import 'controller.dart';

class PopoverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopoverController>(() => PopoverController());
  }
}
