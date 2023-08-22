import 'package:get/get.dart';

import 'controller.dart';

class CircleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CircleController>(() => CircleController());
  }
}
