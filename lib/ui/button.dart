import 'package:flutter/material.dart';
import 'package:shy_ui/styles/color.dart';
import 'package:shy_ui/ui/touchable_highlight.dart';
import 'package:shy_ui/ui/icon/index.dart';
import 'package:shy_ui/utils/common.dart';

/// 大小
/// ```
/// [mini] 小按钮
/// [medium] 中按钮
/// [large] 大按钮
/// [long] 通栏按钮
/// ```
enum ButtonSize { mini, medium, large, long }

/// 形状
/// ```
/// [square] 直角
/// [circle] 圆弧
/// [semicircle] 半圆
/// ```
enum ButtonShape { square, circle, semicircle }

class Button extends StatelessWidget {
  final Function? onPress;
  final String title;
  final double? width;
  final double? height;
  final ButtonSize size;
  final ButtonShape shape;
  final bool plain;
  final bool disabled;
  final BorderRadius? borderRadius;
  final double? borderRadiusSize;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWidget;
  final Color color;
  final Color bgColor;
  final LinearGradient? gradient;
  final String? icon;
  final double iconSize;
  final Color? iconColor;
  final Widget? iconWidget;
  final bool loading;
  final double loadingSize;
  final Color? loadingColor;
  final double loadingStrokeWidth;
  final double loadingOpacity;
  final Color? plainColor;
  final Color? plainBgColor;
  final Color? plainBorderColor;
  final Color? disabledColor;
  final Color? disabledBgColor;
  final bool throttle;
  final int throttleTime;

  /// 按钮
  /// ```
  /// [onPress] 按钮点击事件
  /// [title] 按钮文字
  /// [width] 按钮自定义宽度
  /// [height] 按钮自定义高度
  /// [size] 按钮大小
  /// [shape] 按钮形状
  /// 按钮优先级 disabled > plain > 普通
  /// [plain] 按钮镂空状态 镂空状态下无法使用bgColor、color
  ///         想要自定义颜色,请使用plainColor、plainBgColor、plainBorderColor
  /// [disabled] 按钮禁用状态 禁用状态下无法使用loading下的功能及bgColor、bgColors、color
  ///            想要自定义颜色(无法使用渐变背景),请使用disabledColor、disabledBgColor
  /// [borderRadius] 自定义圆角
  /// [borderRadiusSize] 自定义圆角大小
  /// [fontSize] 按钮文字大小
  /// [fontWeight] 按钮文字粗细
  /// [color] 按钮文字颜色
  /// [bgColor] 按钮背景颜色
  /// [gradient] 按钮背景颜色渐变
  /// [icon] 按钮icon
  /// [iconSize] 按钮icon大小
  /// [iconColor] 按钮icon 颜色 默认是 color
  /// [iconWidget] 按钮icon 自定义
  /// [loading] 设置加载效果
  /// [loadingSize] 加载效果大小
  /// [loadingColor] 加载效果颜色 默认是 color
  /// [loadingStrokeWidth] 加载效果的宽度
  /// [loadingOpacity] 加载效果的透明度
  /// ```
  Button({
    super.key,
    this.onPress,
    required this.title,
    this.width,
    this.height,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.circle,
    this.plain = false,
    this.disabled = false,
    this.borderRadius,
    this.borderRadiusSize,
    this.padding,
    this.fontSize,
    this.fontWidget,
    this.color = Colors.white,
    this.bgColor = AppColor.themeColor,
    this.gradient,
    this.icon,
    this.iconSize = 16,
    this.iconColor,
    this.iconWidget,
    this.loading = false,
    this.loadingSize = 15,
    this.loadingColor,
    this.loadingStrokeWidth = 2,
    this.loadingOpacity = 0.8,
    this.plainColor,
    this.plainBgColor,
    this.plainBorderColor,
    this.disabledColor,
    this.disabledBgColor,
    this.throttle = true,
    this.throttleTime = 2000,
  });
  final double square = 0;
  final double circle = 8;
  final double semicircle = 100;
  final Map<String, dynamic> mini = {
    'width': 60.0,
    'height': 28.0,
    'fontSize': 12.0,
    'fontWidget': FontWeight.normal,
    'padding': const EdgeInsets.symmetric(horizontal: 10),
    'margin': const EdgeInsets.only(right: 6),
  };
  final Map<String, dynamic> medium = {
    'width': 80.0,
    'height': 32.0,
    'fontSize': 13.0,
    'fontWidget': FontWeight.normal,
    'padding': const EdgeInsets.symmetric(horizontal: 10),
    'margin': const EdgeInsets.only(right: 6),
  };
  final Map<String, dynamic> large = {
    'width': 320.0,
    'height': 46.0,
    'fontSize': 16.0,
    'fontWidget': FontWeight.normal,
    'padding': const EdgeInsets.symmetric(horizontal: 12),
    'margin': const EdgeInsets.only(right: 12),
  };
  final Map<String, dynamic> long = {
    'width': double.infinity,
    'height': 46.0,
    'fontSize': 16.0,
    'fontWidget': FontWeight.normal,
    'padding': const EdgeInsets.symmetric(horizontal: 16),
    'margin': const EdgeInsets.only(right: 12),
  };
  final Map disabledStyle = {
    'color': AppColor.threearyText,
    'bgColor': const Color(0xFFD0D8D7),
  };
  final Map plainStyle = {
    'color': AppColor.primaryText,
    'bgColor': Colors.transparent,
    'borderColor': AppColor.placeholderText,
  };

  Map<String, dynamic> init() {
    if (size == ButtonSize.mini) {
      return mini;
    }
    if (size == ButtonSize.medium) {
      return medium;
    }
    if (size == ButtonSize.large) {
      return large;
    }
    return long;
  }

  BorderRadius initBorderRadius() {
    if (borderRadius != null) {
      return borderRadius!;
    }
    return BorderRadius.all(
      Radius.circular(
        borderRadiusSize != null
            ? borderRadiusSize!
            : shape == ButtonShape.square
                ? square
                : shape == ButtonShape.circle
                    ? circle
                    : semicircle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map style = init();
    BorderRadius borderRadius = initBorderRadius();
    Widget buildContent(Color color) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          loading
              ? Container(
                  width: loadingSize,
                  height: loadingSize,
                  margin: style['margin'],
                  child: Opacity(
                    opacity: loadingOpacity,
                    child: CircularProgressIndicator(
                      strokeWidth: loadingStrokeWidth,
                      color: loadingColor ?? color,
                    ),
                  ),
                )
              : Container(),
          if (icon != null)
            Container(
              margin: style['margin'],
              child: IconFont(
                name: icon!,
                size: iconSize,
                color: iconColor ?? color,
              ),
            ),
          if (iconWidget != null)
            Container(
              margin: style['margin'],
              child: iconWidget!,
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize ?? style['fontSize'],
              color: color,
              fontWeight: fontWidget ?? style['fontWidget'],
            ),
          )
        ],
      );
    }

    Widget buildContainer({
      required Color color,
      required Color bgColor,
    }) {
      return TouchableHighlight(
        width: width ?? style['width'],
        height: height ?? style['height'],
        padding: padding ?? style['padding'],
        borderRadius: borderRadius,
        bgColor: bgColor,
        gradient: gradient,
        onPress: throttle
            ? Common.throttle(() {
                if (onPress != null) {
                  onPress!();
                }
              }, throttleTime)
            : () {
                if (onPress != null) {
                  onPress!();
                }
              },
        child: buildContent(color),
      );
    }

    return disabled
        ? GestureDetector(
            onTap: () {
              if (onPress != null) {
                onPress!();
              }
            },
            child: Container(
              width: width ?? style['width'],
              height: height ?? style['height'],
              decoration: BoxDecoration(
                color: disabledBgColor ?? disabledStyle['bgColor'],
                borderRadius: borderRadius,
              ),
              child: buildContent(disabledColor ?? disabledStyle['color']),
            ),
          )
        : plain
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: Border.all(
                    width: 1,
                    color: plainBorderColor ?? plainStyle['borderColor'],
                  ),
                ),
                child: buildContainer(
                  color: plainColor ?? plainStyle['color'],
                  bgColor: plainBgColor ?? plainStyle['bgColor'],
                ),
              )
            : buildContainer(
                color: color,
                bgColor: bgColor,
              );
  }
}
