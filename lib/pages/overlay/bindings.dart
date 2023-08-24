import 'package:get/get.dart';

import 'controller.dart';

class OverlayBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverlayController>(() => OverlayController());
  }
}
