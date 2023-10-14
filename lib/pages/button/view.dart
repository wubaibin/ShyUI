import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/button.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class ButtonPage extends GetView<ButtonController> {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonController>(
      builder: (_) {
        return StageWidget(
          title: "Button 按钮",
          children: [
            const DetailTitleWidget(title: '按钮尺寸', top: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Button(title: '小按钮', size: ButtonSize.mini),
                const SizedBox(height: 8),
                Button(title: '中按钮', size: ButtonSize.medium),
                const SizedBox(height: 8),
                Button(title: '大按钮', size: ButtonSize.large),
                const SizedBox(height: 8),
                Button(title: '通栏按钮', size: ButtonSize.long),
              ],
            ),
            const DetailTitleWidget(title: '设置按钮长和宽'),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Button(title: '按钮', width: 50, height: 50),
            ),
            const DetailTitleWidget(title: '按钮形状'),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button(title: '直角按钮', shape: ButtonShape.square),
                const SizedBox(width: 8),
                Button(title: '圆弧按钮', shape: ButtonShape.circle),
                const SizedBox(width: 8),
                Button(title: '半圆按钮', shape: ButtonShape.semicircle),
              ],
            ),
            const DetailTitleWidget(title: '镂空按钮'),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Button(
                title: '镂空按钮',
                size: ButtonSize.large,
                plain: true,
              ),
            ),
            const DetailTitleWidget(title: '禁用按钮'),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Button(
                title: '禁用按钮',
                size: ButtonSize.large,
                disabled: true,
              ),
            ),
            const DetailTitleWidget(title: '加载状态'),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Button(
                title: '加载状态',
                size: ButtonSize.large,
                loading: true,
              ),
            ),
            const DetailTitleWidget(title: '图标按钮'),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Button(
                title: '图标按钮',
                size: ButtonSize.large,
                icon: 'home',
              ),
            ),
            const DetailTitleWidget(title: '自定义颜色按钮'),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button(title: '单色按钮', bgColor: Colors.amber),
                const SizedBox(width: 8),
                Button(
                  title: '单色按钮',
                  plain: true,
                  plainBgColor: Colors.white,
                ),
                const SizedBox(width: 8),
                Button(
                  title: '渐变色按钮',
                  gradient: const LinearGradient(
                    colors: [Colors.red, Colors.cyan],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
