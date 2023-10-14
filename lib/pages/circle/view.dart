import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/circular_progress_bar.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class CirclePage extends GetView<CircleController> {
  const CirclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CircleController>(
      builder: (_) {
        return const StageWidget(
          title: "CircularProgressBar 圆形进度条",
          children: [
            DetailTitleWidget(title: '基础用法', top: 20),
            SizedBox(height: 8),
            CircularProgressBar(progress: 70, text: "70%"),
            DetailTitleWidget(title: '样式定制'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressBar(
                  progress: 70,
                  strokeWidth: 8,
                  text: "宽度定制",
                ),
                CircularProgressBar(
                  progress: 70,
                  progressColor: Colors.red,
                  backgroundColor: Colors.grey,
                  text: "颜色定制",
                ),
                CircularProgressBar(
                  progress: 70,
                  gradientColors: [
                    Colors.green,
                    Colors.yellow,
                  ],
                  text: "渐变色",
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressBar(
                  progress: 70,
                  progressColor: Colors.green,
                  clockwise: false,
                  text: "逆时针",
                ),
                CircularProgressBar(
                  progress: 70,
                  size: 90,
                  progressColor: Colors.cyan,
                  clockwise: false,
                  text: "大小定制",
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
