import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/ui/loading.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class LoadingPage extends GetView<LoadingController> {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingController>(
      builder: (_) {
        return const StageWidget(
          title: "Loading 加载",
          children: [
            DetailTitleWidget(title: '基础用法', top: 20),
            SizedBox(height: 8),
            LoadingWidget(),
            DetailTitleWidget(title: '自定义大小'),
            SizedBox(height: 8),
            LoadingWidget(size: 30),
            DetailTitleWidget(title: '自定义颜色'),
            SizedBox(height: 8),
            LoadingWidget(color: Colors.amber),
          ],
        );
      },
    );
  }
}
