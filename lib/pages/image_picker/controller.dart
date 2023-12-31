import 'dart:async';

import 'package:shy_ui/ui/dialog.dart';
import 'package:get/get.dart';

import 'index.dart';

class ImagePickerController extends GetxController {
  ImagePickerController();

  final state = ImagePickerState();

  Future<bool> removeImage() async {
    final Completer<bool> completer = Completer();
    $dialog.show(
      content: "是否删除图片",
      success: (value) async {
        if (value.confirm) {
          completer.complete(true);
          return;
        }
        completer.complete(false);
      },
    );
    return await completer.future;
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
