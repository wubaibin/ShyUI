import 'package:shy_ui/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 弹出层
/// ```
/// [show] 展示
/// [hidde] 关闭
/// ```
class $popup {
  static final BuildContext _context = Get.context!;

  /// 显示弹出层
  /// ```
  /// [child] 子组件
  /// [title] 标题
  /// [titleStyle] 自定义标题样式
  /// [locked] 弹出层锁定状态 值为true 点击背景不会被关闭
  /// [bgColor] 弹出层组件背景颜色
  /// [overlyBgColor] 弹出层背景颜色
  /// [duration] 动画过渡时间
  /// [borderRadius] 圆角
  /// [safeArea] 是否留出安全距离
  /// [onCloseTap] 自定义关闭按钮事件
  /// [clear] 是否展示关闭icon
  /// [clearWidget] 自定义关闭按钮
  /// ```
  static void show({
    required Widget child,
    String? title,
    TextStyle titleStyle = const TextStyle(
      fontSize: 17,
      color: AppColor.primaryText,
      fontWeight: FontWeight.w600,
    ),
    bool locked = false,
    Color bgColor = Colors.white,
    Color overlyBgColor = AppColor.maskBgColor,
    int duration = 300,
    double borderRadius = 18,
    bool safeArea = true,
    Function? onCloseTap,
    bool clear = false,
    Widget? clearWidget,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: !locked,
      backgroundColor: overlyBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      context: _context,
      builder: (context) => Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: safeArea ? MediaQuery.of(context).padding.bottom : 0,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: title == null
                ? child
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          title,
                          style: titleStyle,
                        ),
                      ),
                      child,
                    ],
                  ),
          ),
          if (clearWidget != null) clearWidget,
          if (clear && clearWidget == null)
            Positioned(
              top: 11,
              right: 17,
              child: GestureDetector(
                onTap: () {
                  if (onCloseTap != null) {
                    onCloseTap();
                  }
                  hide();
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColor.bgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.clear_rounded,
                    size: 16,
                    color: AppColor.placeholderText,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 关闭弹出层
  static void hide() {
    Navigator.of(_context).pop();
  }
}
