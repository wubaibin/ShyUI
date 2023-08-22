import 'package:flutter/material.dart';
import 'package:flutter_face/components/detail_title.dart';
import 'package:flutter_face/components/stage.dart';
import 'package:flutter_face/ui/checkbox.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class CheckboxPage extends GetView<CheckboxController> {
  const CheckboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckboxController>(
      builder: (_) {
        return StageWidget(
          title: "Checkbox 复选框",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            CheckBoxWidget(data: _.state.baseList, value: const []),
            const DetailTitleWidget(title: '全部禁用'),
            const SizedBox(height: 8),
            CheckBoxWidget(
              data: _.state.baseList,
              value: const ['2'],
              disabled: true,
            ),
            const DetailTitleWidget(title: '单个禁用'),
            const SizedBox(height: 8),
            CheckBoxWidget(data: _.state.disbaledList, value: const ['2']),
            const DetailTitleWidget(title: '自定义图标'),
            const SizedBox(height: 8),
            CheckBoxWidget(
              data: _.state.baseList,
              value: const ['2'],
              activeIcon: 'home',
              activeColor: Colors.red,
              iconSize: 30,
            ),
            const DetailTitleWidget(title: '禁用文本点击'),
            const SizedBox(height: 8),
            CheckBoxWidget(
              data: _.state.baseList,
              value: const ['2'],
              labelDisabled: true,
            ),
            const DetailTitleWidget(title: '设置最大可选数'),
            const SizedBox(height: 8),
            CheckBoxWidget(
              data: _.state.baseList,
              value: const [],
              max: 2,
            ),
            const DetailTitleWidget(title: '设置最小可选数'),
            const SizedBox(height: 8),
            CheckBoxWidget(
              data: _.state.baseList,
              value: const [],
              min: 1,
            ),
          ],
        );
      },
    );
  }
}
