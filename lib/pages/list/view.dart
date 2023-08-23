import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/config/images.dart';
import 'package:flutter_face/ui/list.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class ListPage extends GetView<ListController> {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListController>(
      builder: (_) {
        return StageWidget(
          title: "List 列表",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            const ListContainerWidget(title: "基础用法", showLine: false),
            const DetailTitleWidget(title: '样式定制'),
            const SizedBox(height: 8),
            const ListContainerWidget(
              title: "自定义圆角",
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            const ListContainerWidget(title: "自定义背景", bgColor: Colors.green),
            const ListContainerWidget(
              title: "渐变背景",
              gradient: LinearGradient(
                colors: [Colors.red, Colors.yellow],
              ),
            ),
            const ListContainerWidget(
              title: "自定义标题样式",
              titleStyle: TextStyle(fontSize: 15, color: Colors.amber),
            ),
            const ListContainerWidget(
              title: "隐藏向右按钮",
              showArrow: false,
            ),
            const ListContainerWidget(
              title: "消息未读",
              count: 10,
            ),
            const ListContainerWidget(
              title: "版本号",
              tagContent: "V1.0.0",
              tagContentPadding: EdgeInsets.zero,
              showArrow: false,
            ),
            const ListContainerWidget(
              title: "图标 列表",
              icon: "checkbox_active",
            ),
            ListContainerWidget(
              title: "图片 列表",
              iconWidget: Image.asset(
                ImagesUrl.emptyNoData,
                width: 44,
                height: 44,
                fit: BoxFit.fill,
              ),
            ),
            const ListContainerWidget(
              title: "自定义高度",
              height: 60,
            ),
            const ListContainerWidget(
              title: "自定义内边距",
              padding: EdgeInsets.symmetric(horizontal: 40),
            ),
            const ListContainerWidget(
              leftWidget: Row(
                children: [Text("自定义左边")],
              ),
              rightWidget: Row(
                children: [Text("自定义右边")],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        );
      },
    );
  }
}
