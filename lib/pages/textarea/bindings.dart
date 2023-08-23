import 'package:get/get.dart';

import 'controller.dart';

class TextareaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextareaController>(() => TextareaController());
  }
}
