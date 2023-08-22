import 'package:get/get.dart';

import 'controller.dart';

class DialogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DialogController>(() => DialogController());
  }
}
