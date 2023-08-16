import 'package:get/get.dart';

import 'index.dart';

class HomeController extends GetxController {
  HomeController();

  final state = HomeState();

  // 跳转到详情
  void goToDetailPage(String url) {
    Get.toNamed(url);
  }
}
