import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/config/images.dart';
import 'package:flutter_face/ui/empty.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class EmptyPage extends GetView<EmptyController> {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmptyController>(
      builder: (_) {
        return const StageWidget(
          title: "Empty 空状态",
          children: [
            DetailTitleWidget(title: '基础用法', top: 20),
            SizedBox(height: 8),
            EmptyWidget(),
            DetailTitleWidget(title: '图片大小'),
            SizedBox(height: 8),
            EmptyWidget(width: 240, height: 240),
            DetailTitleWidget(title: '自定义图片和文案'),
            SizedBox(height: 8),
            EmptyWidget(url: ImagesUrl.emptyNoSearch, title: '暂无搜索数据'),
          ],
        );
      },
    );
  }
}
