import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/tab_bar/index.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final List<TabBarModel> data;
  final TabController controller;
  final ValueChanged<int>? onTap;
  final bool isScrollable;
  final Decoration indicator;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Color dotColor;
  final Widget? dotWidget;
  final Color countColor;
  final Widget Function(String count)? countWidget;
  final int maxCount;

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
  /// [dotColor] 圆点徽标颜色
  /// [dotWidget] 自定义圆点徽标
  /// [countColor] 徽标颜色
  /// [customCountWidget] 自定义徽标
  /// [maxCount] 徽标数字最大值，超过最大值时显示$maxCount+
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
    this.dotColor = AppColor.errorColor,
    this.dotWidget,
    this.countColor = AppColor.errorColor,
    this.countWidget,
    this.maxCount = 99,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: data
          .map((e) => Tab(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Text(e.label),
                    if (e.dot == true)
                      dotWidget ??
                          Positioned(
                            left: 36,
                            top: 2,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColor,
                              ),
                            ),
                          ),
                    if (e.count != null && e.count != 0)
                      countWidget != null
                          ? countWidget!(_countText(e.count!))
                          : Positioned(
                              left: 32,
                              top: -6,
                              child: Container(
                                height: 14,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: countColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _countText(e.count!),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                  ],
                ),
              ))
          .toList(),
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

  String _countText(int count) {
    return "${count > maxCount ? '$maxCount+' : count}";
  }
}
