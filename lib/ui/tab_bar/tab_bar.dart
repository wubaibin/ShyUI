import 'package:flutter_face/models/options.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/tab_bar/tab_indicator.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final List<OptionsModel> data;
  final TabController controller;
  final ValueChanged<int>? onTap;
  final bool isScrollable;
  final Decoration indicator;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;

  /// 标签页
  /// ```
  /// [data] 数据
  /// [controller] 控制器
  /// [onTap] 点击事件
  /// [isScrollable] 是否滚动
  /// [indicator] 当前选中选项的指示器
  /// [labelColor] 选中颜色
  /// [unselectedLabelColor] 未选中颜色
  /// [labelStyle] 选中文案样式
  /// [unselectedLabelStyle] 未选中文案样式
  /// ```
  const TabBarWidget({
    super.key,
    required this.data,
    required this.controller,
    this.onTap,
    this.isScrollable = true,
    this.indicator = const TabIndicator(width: 20, height: 3, bottom: 0),
    this.labelColor = AppColor.themeColor,
    this.unselectedLabelColor = AppColor.secondaryText,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.unselectedLabelStyle = const TextStyle(fontSize: 14),
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: data.map((e) => Tab(child: Text(e.label))).toList(),
      controller: controller,
      onTap: onTap,
      indicatorPadding: EdgeInsets.zero,
      indicator: indicator,
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: isScrollable,
      labelColor: labelColor,
      labelStyle: labelStyle,
      unselectedLabelColor: unselectedLabelColor,
      unselectedLabelStyle: unselectedLabelStyle,
    );
  }
}
