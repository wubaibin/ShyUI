import 'package:flutter/material.dart';
import 'package:shy_ui/models/navigation_item.dart';
import 'package:shy_ui/pages/home/index.dart';
import 'package:shy_ui/pages/user/index.dart';

class MainState {
  // 页面下标
  int index = 0;
  // 底部导航
  final List<NavigationItemModel> bottomBarItems = [
    NavigationItemModel(
      label: '首页',
      selectIcon: 'home',
      unselectIcon: 'home',
    ),
    NavigationItemModel(
      label: '我的',
      selectIcon: 'user',
      unselectIcon: 'user',
      count: 0,
    ),
  ];
  final List<Widget> pages = [
    const HomePage(),
    const UserPage(),
  ];
}
