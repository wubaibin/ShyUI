import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/list.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class PopupPage extends GetView<PopupController> {
  const PopupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopupController>(
      builder: (_) {
        return StageWidget(
          title: "Popup 弹出层",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '弹窗提示',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: _.listTap,
            ),
            const DetailTitleWidget(title: '关闭图标', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '关闭图标',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: _.listClearTap,
            ),
            const DetailTitleWidget(title: '弹窗标题', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '弹窗标题',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: _.listTitleTap,
            ),
            const DetailTitleWidget(title: '直角弹窗', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '直角弹窗',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: _.listRadiusTap,
            ),
            const DetailTitleWidget(title: '锁定弹窗', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '锁定弹窗',
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: _.listLockTap,
            ),
          ],
        );
      },
    );
  }
}
