import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/list.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class ToastPage extends GetView<ToastController> {
  const ToastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToastController>(
      builder: (_) {
        return StageWidget(
          title: "Toast 轻提示",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            ListContainerWidget(
              title: '文字提示',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              onPress: () {
                _.textTap(false);
              },
            ),
            ListContainerWidget(
              title: '文字提示期间可以点击其他',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              onPress: _.textOtherTap,
            ),
            ListContainerWidget(
              title: '文字提示可以点击关闭',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              onPress: () {
                _.textTap(true);
              },
            ),
            ListContainerWidget(title: '加載提示', onPress: _.loadingTap),
            ListContainerWidget(
              title: '成功提示',
              onPress: () {
                _.iconTap('success');
              },
            ),
            ListContainerWidget(
              title: '失败提示',
              onPress: () {
                _.iconTap('fail');
              },
            ),
            ListContainerWidget(
              title: '自定义图标提示',
              showLine: false,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              onPress: () {
                _.iconTap('user');
              },
            ),
          ],
        );
      },
    );
  }
}
