import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/app_bar.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class AppBarPage extends GetView<AppBarController> {
  const AppBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppBarController>(
      builder: (_) {
        return const StageWidget(
          title: "AppBar 导航栏",
          children: [
            DetailTitleWidget(title: '基础用法', top: 20),
            SizedBox(height: 12),
            AppBarWidget(title: "导航栏"),
            DetailTitleWidget(title: '去掉返回按钮', top: 20),
            SizedBox(height: 12),
            AppBarWidget(title: "导航栏", leading: SizedBox()),
          ],
        );
      },
    );
  }
}
