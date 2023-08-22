import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/appbar.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "home",
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const AppBarWidget(title: "首页", leading: SizedBox()),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle("基础组件"),
                  const ListWidget(title: 'Button 按钮', url: '/button'),
                  const ListWidget(title: 'Icon 图标', url: '/icon'),
                  const ListWidget(title: 'Popup 弹出层', url: '/popup'),
                  const ListWidget(title: 'Toast 轻提示', url: '/toast'),
                  const ListWidget(title: 'Transition 动画', url: '/transition'),
                  _buildTitle("表单组件"),
                  const ListWidget(title: 'Input 输入框', url: '/input'),
                  const ListWidget(title: 'Checkbox 复选框', url: '/checkbox'),
                  const ListWidget(title: 'Radio 单选框', url: '/radio'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16),
      child: Text(title, style: CommonStyle.secondaryText14),
    );
  }
}
