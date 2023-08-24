import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/ui/button.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class OverlayPage extends GetView<OverlayController> {
  const OverlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OverlayController>(
      builder: (_) {
        return StageWidget(
          title: "Overlay 遮罩层",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            Button(title: "显示遮罩层", onPress: _.showBaseTap),
          ],
        );
      },
    );
  }
}
