import 'package:get/get.dart';

import 'controller.dart';

class LoadingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}
