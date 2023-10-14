import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/icon/index.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class IconPage extends GetView<IconController> {
  const IconPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IconController>(
      builder: (_) {
        return const StageWidget(
          title: "Icon 图标",
          children: [
            DetailTitleWidget(title: '基础用法', top: 20),
            SizedBox(height: 8),
            Row(
              children: [
                IconFont(name: 'home'),
                SizedBox(width: 8),
                IconFont(name: 'user'),
              ],
            ),
            DetailTitleWidget(title: '图标样式'),
            SizedBox(height: 8),
            Row(
              children: [
                IconFont(name: 'home', size: 24, color: Colors.amber),
                SizedBox(width: 8),
                IconFont(name: 'user', size: 32, color: Colors.green),
              ],
            ),
          ],
        );
      },
    );
  }
}
