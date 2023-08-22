import 'package:get/get.dart';

import 'controller.dart';

class RadioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RadioController>(() => RadioController());
  }
}
