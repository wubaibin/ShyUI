import 'package:get/get.dart';

import 'controller.dart';

class ImagePickerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
  }
}
