import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/ui/radio.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class RadioPage extends GetView<RadioController> {
  const RadioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RadioController>(
      builder: (_) {
        return StageWidget(
          title: "Radio 单选框",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            RadioWidget(data: _.state.baseList, value: ""),
            const DetailTitleWidget(title: '上下排序'),
            const SizedBox(height: 8),
            RadioWidget(
              data: _.state.baseList,
              value: "",
              direction: RadioDirection.vertical,
            ),
            const DetailTitleWidget(title: '全部禁用'),
            const SizedBox(height: 8),
            RadioWidget(data: _.state.baseList, value: "", disabled: true),
            const DetailTitleWidget(title: '部分禁用'),
            const SizedBox(height: 8),
            RadioWidget(
              data: _.state.disableList,
              value: "2",
            ),
            const DetailTitleWidget(title: '自定义图标'),
            const SizedBox(height: 8),
            RadioWidget(
              data: _.state.baseList,
              value: "2",
              iconSize: 30,
              activeIcon: "checkbox_active",
              inactiveIcon: "checkbox_inactive",
            ),
            const DetailTitleWidget(title: '禁用文本点击'),
            const SizedBox(height: 8),
            RadioWidget(
              data: _.state.baseList,
              value: "2",
              labelDisabled: true,
            ),
          ],
        );
      },
    );
  }
}
