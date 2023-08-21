import 'package:flutter/material.dart';
import 'package:flutter_face/ui/popup.dart';
import 'package:get/get.dart';

import 'index.dart';

class PopupController extends GetxController {
  PopupController();

  final state = PopupState();

  void listTap() {
    $popup.show(
      child: const SizedBox(
        height: 300,
      ),
    );
  }

  void listClearTap() {
    $popup.show(
      clear: true,
      child: const SizedBox(
        height: 300,
      ),
    );
  }

  void listTitleTap() {
    $popup.show(
      title: "弹窗标题",
      child: const SizedBox(
        height: 300,
      ),
    );
  }

  void listRadiusTap() {
    $popup.show(
      title: "弹窗标题",
      borderRadius: 0,
      child: const SizedBox(
        height: 300,
      ),
    );
  }
}
