import 'package:flutter/material.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/icon/index.dart';
import 'package:shy_ui/ui/touchable_highlight.dart';
import 'package:shy_ui/utils/common.dart';

class ListContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final TextStyle titleStyle;
  final Function? onPress;
  final String? icon;
  final double? iconSize;
  final Color? iconColor;
  final Widget? iconWidget;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;
  final Color bgColor;
  final LinearGradient? gradient;
  final double activeOpacity;
  final Color activeBgColor;
  final bool showLine;
  final Color lineColor;
  final bool showArrow;
  final double arrowSize;
  final Color arrowColor;
  final String? tagContent;
  final EdgeInsets tagContentPadding;
  final TextStyle tagContentStyle;
  final int? count;
  final int maxCount;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final bool throttle;
  final int throttleTime;

  /// 列表
  /// ```
  /// [width] 列表宽度
  /// [height] 列表高度
  /// [title] 列表标题
  /// [titleStyle] 列表标题自定义样式
  /// [onPress] 列表点击事件
  /// [icon] 列表图标
  /// [iconSize] 列表图标大小
  /// [iconColor] 列表图标颜色
  /// [iconWidget] 自定义列表图标
  /// [padding] 列表内边距
  /// [margin] 列表外边距
  /// [borderRadius] 列表圆角
  /// [bgColor] 列表背景颜色
  /// [gradient] 列表渐变
  /// [activeOpacity] 列表点击后颜色透明度
  /// [activeBgColor] 列表点击后颜色
  /// [showLine] 是否展示列表底线
  /// [lineColor] 列表底线颜色
  /// [showArrow] 是否展示列表右边箭头
  /// [arrowSize] 列表右边箭头大小
  /// [arrowColor] 列表右边箭头颜色
  /// [tagContent] 列表右边提示内容
  /// [tagContentPadding] 列表右边提示内容Padding
  /// [tagContentStyle] 列表右边提示内容自定义样式
  /// [count] 列表右边显示带徽标数值
  /// [maxCount] 列表右边显示带徽标数值的最大值
  /// [leftWidget] 列表自定义左边
  /// [rightWidget] 列表自定义右边
  /// [throttle] 列表点击事件是否防止重复点击
  /// [throttleTime] 列表点击事件防止重复点击时间间隔
  /// ```
  const ListContainerWidget({
    super.key,
    this.width = double.infinity,
    this.height = 44,
    this.title = "",
    this.titleStyle = const TextStyle(
      fontSize: 14,
      color: AppColor.primaryText,
    ),
    this.onPress,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.iconWidget,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.margin = const EdgeInsets.only(),
    this.borderRadius = BorderRadius.zero,
    this.bgColor = Colors.white,
    this.gradient,
    this.activeOpacity = 0.2,
    this.activeBgColor = const Color(0xFF333333),
    this.showLine = true,
    this.lineColor = AppColor.bgColor,
    this.showArrow = true,
    this.arrowSize = 16,
    this.arrowColor = AppColor.threearyText,
    this.tagContent,
    this.tagContentPadding = const EdgeInsets.only(right: 12),
    this.tagContentStyle = const TextStyle(
      fontSize: 15,
      color: AppColor.threearyText,
    ),
    this.count,
    this.maxCount = 99,
    this.leftWidget,
    this.rightWidget,
    this.throttle = true,
    this.throttleTime = 2000,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TouchableHighlight(
        width: width,
        height: height,
        padding: padding,
        borderRadius: borderRadius,
        bgColor: bgColor,
        gradient: gradient,
        activeOpacity: activeOpacity,
        activeBgColor: activeBgColor,
        onPress: !throttle
            ? () {
                if (onPress != null) {
                  onPress!();
                }
              }
            : Common.throttle(() {
                if (onPress != null) {
                  onPress!();
                }
              }, throttleTime),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: showLine ? BorderSide(color: lineColor) : BorderSide.none,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leftWidget == null
                  ? Expanded(
                      child: Row(
                        children: [
                          if (icon != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconFont(
                                name: icon!,
                                color: iconColor ?? AppColor.themeColor,
                                size: iconSize ?? 12,
                              ),
                            ),
                          if (iconWidget != null) iconWidget!,
                          Text(title, style: titleStyle),
                        ],
                      ),
                    )
                  : leftWidget!,
              rightWidget == null
                  ? Row(
                      children: [
                        if (tagContent != null)
                          Padding(
                            padding: tagContentPadding,
                            child: Text(tagContent!, style: tagContentStyle),
                          ),
                        if (count != null && count != 0) _buildDot(),
                        if (showArrow)
                          Icon(
                            Icons.arrow_forward_ios,
                            size: arrowSize,
                            color: arrowColor,
                          ),
                      ],
                    )
                  : rightWidget!,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      height: 18,
      constraints: const BoxConstraints(minWidth: 16),
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: AppColor.errorColor,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        '${count! > maxCount ? '$maxCount+' : count}',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
