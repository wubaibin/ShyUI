import 'package:flutter/material.dart';
import 'package:flutter_face/ui/overlay.dart';
import 'package:get/get.dart';

import 'index.dart';

class OverlayController extends GetxController {
  OverlayController();

  final state = OverlayWidgetState();

  void showBaseTap() {
    $overlay.show(child: const SizedBox());
  }

  void showContentTap() {
    $overlay.show(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.white,
      ),
    );
  }

  void showTransitionTap() {
    $overlay.show(
      showTransition: true,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.white,
      ),
    );
  }
}
