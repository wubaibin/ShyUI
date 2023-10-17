import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/popover/show.dart';
import 'package:shy_ui/ui/popover/model.dart';
import 'package:shy_ui/utils/screen.dart';

enum Placement {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
  left,
  leftTop,
  leftBottom,
  right,
  rightTop,
  rightBottom,
}

class Popover extends StatelessWidget {
  final List<PopoverItem> data;
  final dynamic value;
  final Widget child;
  final ValueChanged<PopoverItem>? onTap;
  final Placement placement;
  final double width;
  final double height;
  final double dotWidth;
  final double dotHeight;
  final double runSpacing;
  final double spacing;
  final double dotRunSpacing;
  final double dotSpacing;
  final List<BoxShadow> boxShadow;
  final Color bgColor;
  final Color disbaledColor;
  final Color activeColor;
  final Color color;
  final double borderRadius;
  final double dotBorderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final Widget Function(PopoverItem data)? customList;
  final Widget? customPopover;
  final Function? onBeforeTap;
  final Function? onBeforeClose;

  /// 气泡框
  /// ```
  /// [data] 列表数据
  /// [value] 选择的数据
  /// [child] 在哪里展示
  /// [onTap] 点击事件
  /// [placement] 方向
  /// [width] 列表宽度 customList不为null时是customList的宽度
  /// [height] 列表高度 customList不为null时是customList的高度
  /// [dotWidth] 尖角的宽度
  /// [dotHeight] 尖角的高度
  /// [runSpacing] 上下间距
  /// [spacing] 左右间距
  /// [dotRunSpacing] 尖角上下间距
  /// [dotSpacing] 尖角左右间距
  /// [boxShadow] 阴影
  /// [bgColor] 背景颜色
  /// [disbaledColor] 禁用颜色
  /// [activeColor] 选中颜色
  /// [color] 默认颜色
  /// [borderRadius] 圆角
  /// [dotBorderRadius] 尖角的圆角
  /// [padding] 内边距
  /// [fontSize] 文字大小
  /// [customList] 自定义列表
  /// [customPopover] 自定义气泡框
  /// [onBeforeTap] 点击之前触发
  /// [onBeforeClose] 关闭之前触发
  /// ```
  Popover({
    super.key,
    required this.data,
    this.value,
    required this.child,
    this.onTap,
    this.placement = Placement.bottom,
    this.width = 110,
    this.height = 40,
    this.dotWidth = 14,
    this.dotHeight = 14,
    this.runSpacing = 4,
    this.spacing = 0,
    this.dotRunSpacing = 0,
    this.dotSpacing = 0,
    this.boxShadow = const [
      BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 1))
    ],
    this.bgColor = Colors.white,
    this.disbaledColor = AppColor.placeholderText,
    this.activeColor = AppColor.themeColor,
    this.color = AppColor.primaryText,
    this.borderRadius = 12,
    this.dotBorderRadius = 4,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.fontSize = 15,
    this.customList,
    this.customPopover,
    this.onBeforeTap,
    this.onBeforeClose,
  });

  final GlobalKey _key = GlobalKey();

  void showTap() {
    if (data.isEmpty) {
      return;
    }
    if (onBeforeTap != null) {
      onBeforeTap!();
    }
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final distance = renderBox.localToGlobal(Offset.zero);
    ShowPopover.show(
      child: _buildContainer(
        data: data,
        position: _disponsePopoverPosition(distance, size),
      ),
      dotChild: _buildDot(_disponseDotPosition(distance, size)),
      onBeforeClose: onBeforeClose,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTap();
      },
      child: Container(
        key: _key,
        child: child,
      ),
    );
  }

  double _getRunSpacing() {
    if (placement.index <= 5) {
      return runSpacing;
    }
    return runSpacing == 4 ? 0 : runSpacing;
  }

  double _getSpacing() {
    if (placement.index >= 6) {
      return spacing == 0 ? 4 : spacing;
    }
    return spacing;
  }

  double _disponsePopoverTopBottom(Offset distance) {
    return Screen.height - distance.dy + dotHeight * 3 / 4 + _getRunSpacing();
  }

  double _disponsePopoverBottomTop(Offset distance, Size size) {
    return distance.dy + size.height + dotHeight + _getRunSpacing();
  }

  double _disponsePopoverLeftRight(Offset distance) {
    return Screen.width - distance.dx + dotWidth - dotWidth / 4 + _getSpacing();
  }

  double _disponsePopoverRightLeft(Offset distance, Size size) {
    return distance.dx + size.width + dotWidth - dotWidth / 2 + _getSpacing();
  }

  PopoverPosition _disponsePopoverPosition(Offset distance, Size size) {
    switch (placement) {
      case Placement.top:
        return PopoverPosition(
          bottom: _disponsePopoverTopBottom(distance),
          left: distance.dx + (size.width - width) / 2 + _getSpacing(),
        );
      case Placement.topLeft:
        return PopoverPosition(
          bottom: _disponsePopoverTopBottom(distance),
          left: distance.dx + _getSpacing(),
        );
      case Placement.topRight:
        return PopoverPosition(
          bottom: _disponsePopoverTopBottom(distance),
          right: Screen.width - distance.dx - size.width + _getSpacing(),
        );
      case Placement.bottom:
        return PopoverPosition(
          top: _disponsePopoverBottomTop(distance, size),
          left: distance.dx + (size.width - width) / 2 + _getSpacing(),
        );
      case Placement.bottomLeft:
        return PopoverPosition(
          top: _disponsePopoverBottomTop(distance, size),
          left: distance.dx + _getSpacing(),
        );
      case Placement.bottomRight:
        return PopoverPosition(
          top: _disponsePopoverBottomTop(distance, size),
          right: Screen.width - distance.dx - size.width + _getSpacing(),
        );
      case Placement.left:
        return PopoverPosition(
          top: distance.dy - (data.length * height) / 2 + size.height / 2,
          right: _disponsePopoverLeftRight(distance),
        );
      case Placement.leftTop:
        return PopoverPosition(
          top: distance.dy - _getRunSpacing(),
          right: _disponsePopoverLeftRight(distance),
        );
      case Placement.leftBottom:
        return PopoverPosition(
          bottom: Screen.height - distance.dy - size.height - _getRunSpacing(),
          right: _disponsePopoverLeftRight(distance),
        );
      case Placement.right:
        return PopoverPosition(
          top: distance.dy - (data.length * height) / 2 + size.height / 2,
          left: _disponsePopoverRightLeft(distance, size),
        );
      case Placement.rightTop:
        return PopoverPosition(
          top: distance.dy - _getRunSpacing(),
          left: _disponsePopoverRightLeft(distance, size),
        );
      case Placement.rightBottom:
        return PopoverPosition(
          bottom: Screen.height - distance.dy - size.height - _getRunSpacing(),
          left: _disponsePopoverRightLeft(distance, size),
        );
    }
  }

  static void hide() {
    ShowPopover.hide();
  }

  Widget _buildContainer({
    required List<PopoverItem> data,
    required PopoverPosition position,
  }) {
    return Positioned(
      top: position.top,
      right: position.right,
      bottom: position.bottom,
      left: position.left,
      child: customPopover != null
          ? customPopover!
          : Container(
              decoration: BoxDecoration(
                color: bgColor,
                boxShadow: boxShadow,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              child: Column(
                children: data
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          if (e.disabled) {
                            return;
                          }
                          hide();
                          if (onTap != null) {
                            onTap!(e);
                          }
                        },
                        child: customList != null
                            ? customList!(e)
                            : Container(
                                width: width,
                                height: height,
                                padding: padding,
                                alignment: Alignment.center,
                                child: Text(
                                  e.label,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: e.disabled
                                        ? disbaledColor
                                        : e.value == value
                                            ? activeColor
                                            : color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  DotPosition _disponseDotPosition(Offset distance, Size size) {
    switch (placement) {
      case Placement.top || Placement.topLeft || Placement.topRight:
        return DotPosition(
          top: distance.dy - dotHeight - dotHeight / 4 - _getRunSpacing(),
          left: distance.dx + size.width / 2 - dotWidth / 2 + dotSpacing,
          angle: pi / 4,
        );
      case Placement.bottom || Placement.bottomLeft || Placement.bottomRight:
        return DotPosition(
          top: distance.dy + size.height + dotHeight / 2 + _getRunSpacing(),
          left: distance.dx + size.width / 2 - dotWidth / 2 + dotSpacing,
          angle: pi * 5 / 4,
        );
      case Placement.left || Placement.leftBottom || Placement.leftTop:
        return DotPosition(
          top: distance.dy + size.height / 2 - dotHeight / 2 + dotRunSpacing,
          left: distance.dx - (dotWidth + dotWidth / 4) - _getSpacing(),
          angle: pi * 7 / 4,
        );
      case Placement.right || Placement.rightBottom || Placement.rightTop:
        return DotPosition(
          top: distance.dy + size.height / 2 - dotHeight / 2 + dotRunSpacing,
          left: distance.dx + size.width + _getSpacing(),
          angle: pi * 3 / 4,
        );
    }
  }

  Widget _buildDot(DotPosition postion) {
    return Positioned(
      top: postion.top,
      left: postion.left,
      child: Transform.rotate(
        angle: postion.angle,
        child: ClipPath(
          clipper: _TriangleClipper(),
          child: Container(
            width: dotWidth,
            height: dotHeight,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(dotBorderRadius),
              boxShadow: boxShadow,
            ),
          ),
        ),
      ),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_TriangleClipper oldClipper) => false;
}
