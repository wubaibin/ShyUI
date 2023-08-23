import 'package:get/get.dart';

import 'controller.dart';

class TabBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabBarController>(() => TabBarController());
  }
}
