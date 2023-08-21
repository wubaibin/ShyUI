import 'package:get/get.dart';

import 'controller.dart';

class InputBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputController>(() => InputController());
  }
}
