import 'package:flutter/material.dart';
import 'package:flutter_face/ui/dialog.dart';
import 'package:get/get.dart';

import 'index.dart';

class DialogController extends GetxController {
  DialogController();

  final state = DialogState();

  void alertTap(String title) {
    $dialog.show(
      type: $dialogType.alert,
      title: title,
      content: "这是一个提示弹窗",
    );
  }

  void confirmTap() {
    $dialog.show(
      type: $dialogType.confirm,
      content: "这是一个确认弹窗",
    );
  }

  void customTap() {
    $dialog.show(
      type: $dialogType.confirm,
      child: Container(
        width: 200,
        height: 100,
        margin: const EdgeInsets.all(24),
        color: Colors.amber,
      ),
    );
  }
}
