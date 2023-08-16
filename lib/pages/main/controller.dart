import 'package:get/get.dart';

import 'index.dart';

class MainController extends GetxController {
  MainController();

  final state = MainState();

  void onIndexChanged(int index) {
    state.index = index;
    update(["main"]);
  }

  @override
  void onInit() {
    super.onInit();
    onIndexChanged(Get.arguments ?? state.index);
  }
}
