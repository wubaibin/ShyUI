import 'package:get/get.dart';

import 'controller.dart';

class CheckboxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckboxController>(() => CheckboxController());
  }
}
