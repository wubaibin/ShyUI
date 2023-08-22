import 'package:get/get.dart';

import 'controller.dart';

class EmptyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmptyController>(() => EmptyController());
  }
}
