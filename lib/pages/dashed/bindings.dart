import 'package:get/get.dart';

import 'controller.dart';

class DashedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashedController>(() => DashedController());
  }
}
