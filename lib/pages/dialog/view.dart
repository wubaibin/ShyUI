import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/ui/list.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class DialogPage extends GetView<DialogController> {
  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogController>(
      builder: (_) {
        return StageWidget(
          title: "Dialog 弹出框",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '提示弹窗',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              onPress: () {
                _.alertTap("提示");
              },
            ),
            ListContainerWidget(
              title: '提示弹窗（无标题）',
              onPress: () {
                _.alertTap("");
              },
            ),
            ListContainerWidget(
              title: '确认弹窗',
              showLine: false,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              onPress: _.confirmTap,
            ),
            const DetailTitleWidget(title: '自定义content'),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '自定义弹窗',
              showLine: false,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onPress: _.customTap,
            ),
          ],
        );
      },
    );
  }
}
