import 'package:flutter_face/config/index.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final Color bgColor;
  final Color color;
  final Function? backTap;

  /// 顶部导航栏
  /// ```
  /// [title] 标题
  /// [leading] 左侧占位组件
  /// [bottom] 底部占位组件
  /// [actions] 右边组件
  /// [bgColor] 背景颜色
  /// [color] 导航栏字体和icon颜色
  /// [backTap] 返回前执行操作
  /// ```
  const AppBarWidget({
    super.key,
    this.title = "",
    this.leading,
    this.bottom,
    this.actions,
    this.titleWidget,
    this.bgColor = AppColor.appBarBgColor,
    this.color = AppColor.primaryText,
    this.backTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      title: titleWidget ??
          Text(
            title,
            style: TextStyle(color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      leading: leading ?? _leadingWidget(),
      actions: actions,
      bottom: bottom,
    );
  }

  Widget _leadingWidget() {
    return GestureDetector(
      onTap: () {
        if (backTap != null) {
          backTap!();
          return;
        }
        Get.back();
      },
      child: Icon(
        Icons.arrow_back_ios_rounded,
        size: 22,
        color: color,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      (bottom != null ? bottom!.preferredSize.height.toDouble() : 0) +
          Config.appBarHeight);
}
