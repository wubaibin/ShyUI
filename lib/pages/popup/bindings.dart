import 'package:get/get.dart';

import 'controller.dart';

class PopupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopupController>(() => PopupController());
  }
}
