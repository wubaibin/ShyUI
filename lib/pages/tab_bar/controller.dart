import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class TabBarController extends GetxController with GetTickerProviderStateMixin {
  TabBarController();

  final state = TabBarState();

  late TabController tabBaseController;

  late TabController tabScrollController;

  @override
  void onInit() {
    super.onInit();
    tabBaseController = TabController(
      vsync: this,
      length: state.tabBaseList.length,
    );

    tabScrollController = TabController(
      vsync: this,
      length: state.tabScrollList.length,
    );
  }

  @override
  void onClose() {
    super.onClose();
    tabBaseController.dispose();
    tabScrollController.dispose();
  }
}
