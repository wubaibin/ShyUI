import 'package:get/get.dart';

import 'controller.dart';

class TransitionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransitionController>(() => TransitionController());
  }
}
