import 'package:get/get.dart';

import 'controller.dart';

class NoticeBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeBarController>(() => NoticeBarController());
  }
}
