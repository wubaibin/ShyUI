import 'package:get/get.dart';

import 'controller.dart';

class ButtonBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ButtonController>(() => ButtonController());
  }
}
