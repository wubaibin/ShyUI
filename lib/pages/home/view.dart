import 'package:flutter/material.dart';
import 'package:flutter_face/config/index.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/app_bar.dart';
import 'package:flutter_face/utils/screen.dart';
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
              padding: EdgeInsets.fromLTRB(
                  16, 0, 16, Config.bottomAppBarHeight + Screen.bottomBar + 24),
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
                  const ListWidget(title: 'Textarea 多行输入框', url: '/textarea'),
                  const ListWidget(title: 'Checkbox 复选框', url: '/checkbox'),
                  const ListWidget(title: 'Radio 单选框', url: '/radio'),
                  _buildTitle("反馈组件"),
                  const ListWidget(title: 'Dialog 弹出框', url: '/dialog'),
                  const ListWidget(title: 'Overlay 遮罩层', url: '/overlay'),
                  const ListWidget(title: 'Loading 加载', url: '/loading'),
                  _buildTitle("展示组件"),
                  const ListWidget(
                    title: 'CircularProgressBar 圆形进度条',
                    url: '/circle',
                  ),
                  const ListWidget(title: 'List 列表', url: '/list'),
                  const ListWidget(title: 'Dashed 虚线和虚线容器', url: '/dashed'),
                  const ListWidget(title: 'Empty 空状态', url: '/empty'),
                  _buildTitle("导航组件"),
                  const ListWidget(title: 'AppBar 导航栏', url: '/appbar'),
                  const ListWidget(title: 'TabBar 标签页', url: '/tabbar'),
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
