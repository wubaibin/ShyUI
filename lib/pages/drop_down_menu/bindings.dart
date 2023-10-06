import 'package:get/get.dart';

import 'controller.dart';

class DropDownMenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DropDownMenuController>(() => DropDownMenuController());
  }
}
