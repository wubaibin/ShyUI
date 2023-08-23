import 'package:flutter/material.dart';
import 'package:flutter_face/styles/color.dart';
import 'package:flutter_face/ui/touchable_highlight.dart';
import 'package:flutter_face/utils/screen.dart';
import 'package:get/get.dart';

enum $dialogType { alert, confirm }

/// 模态框
/// ```
/// [show] 展示
/// [hide] 关闭
/// ```
class $dialog {
  static OverlayEntry? _overlayEntry;

  /// 显示模态框
  /// ```
  /// [type] 设置模态框的类型 [$dialogType.alert] 提示框 [$dialogType.confirm] 确认框
  /// [locked] 设置背景是否为锁定态
  /// [title] 设置模态框的标题
  /// [content] 设置模态框的内容 content 和 child 只能存在一个优先child
  /// [confirmText] 确定按钮的文本
  /// [confirmColor] 确定按钮的文本颜色
  /// [cancelText] 取消按钮的文本
  /// [cancelColor] 取消按钮的文本颜色
  /// [child] 插槽 content 和 child 只能存在一个优先child
  /// [success] 点击按钮回调 res.confirm 返回true 点击确定按钮 res.cancel 返回true 点击确定按钮
  /// [beforeClose] 关闭前的回调函数 res 返回 background 点击背景图 confirm 点击确定按钮 cancel 点击确定按钮
  ///
  /// 关闭模态框 $dialog.hide()
  /// ```
  static void show({
    $dialogType type = $dialogType.confirm,
    bool locked = true,
    String title = "提示",
    String content = '',
    String confirmText = "确认",
    Color confirmColor = AppColor.themeColor,
    String cancelText = "取消",
    Color cancelColor = AppColor.primaryText,
    double borderRadius = 12,
    ValueChanged<$dialogSuccess>? success,
    ValueChanged<String>? beforeColse,
    Widget? child,
    double? width,
  }) {
    // dialog 和 toast 能否同时使用
    // if (_overlayEntry != null) {
    //   hide();
    // }
    _overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () {
            if (locked) {
              return;
            }
            if (beforeColse != null) {
              beforeColse('background');
              return;
            }
            hide();
          },
          child: _buildContainer(
            type: type,
            width: width ?? Screen.width * 0.82,
            title: title,
            content: content,
            confirmText: confirmText,
            confirmColor: confirmColor,
            cancelText: cancelText,
            cancelColor: cancelColor,
            borderRadius: borderRadius,
            child: child,
            success: success,
            beforeColse: beforeColse,
          ),
        ),
      );
    });
    Navigator.of(Get.context!).overlay?.insert(_overlayEntry!);
  }

  static Widget _buildContainer({
    required $dialogType type,
    required double width,
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    required Color confirmColor,
    required Color cancelColor,
    required double borderRadius,
    Widget? child,
    ValueChanged<$dialogSuccess>? success,
    ValueChanged<String>? beforeColse,
  }) {
    return Container(
      width: Screen.width,
      height: Screen.height,
      color: AppColor.maskBgColor,
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Container(
              width: width,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTitle(title: title),
                  child ?? _buildContent(content: content),
                  Row(
                    children: [
                      type == $dialogType.confirm
                          ? _buildButton(
                              type: 'cancel',
                              width: width / 2,
                              text: cancelText,
                              color: cancelColor,
                              borderRadius: borderRadius,
                              success: success,
                              beforeColse: beforeColse,
                            )
                          : Container(),
                      _buildButton(
                        type: 'confirm',
                        width: type == $dialogType.confirm ? width / 2 : width,
                        text: confirmText,
                        color: confirmColor,
                        borderRadius: borderRadius,
                        success: success,
                        beforeColse: beforeColse,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTitle({required String title}) {
    return title != ''
        ? Container(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColor.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container();
  }

  static Widget _buildContent({required String content}) {
    return content != ''
        ? Container(
            padding: const EdgeInsets.fromLTRB(32, 25, 32, 32),
            child: Text(
              content,
              style: const TextStyle(
                color: AppColor.secondaryText,
                fontSize: 17,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : Container(padding: const EdgeInsets.only(bottom: 32));
  }

  static Widget _buildButton({
    required String type,
    required double width,
    required String text,
    required Color color,
    required double borderRadius,
    ValueChanged<$dialogSuccess>? success,
    ValueChanged<String>? beforeColse,
  }) {
    return TouchableHighlight(
      width: width,
      height: 56,
      onPress: () {
        if (success != null) {
          success($dialogSuccess.fromJson({
            'confirm': type == 'confirm',
            'cancel': type == 'cancel',
          }));
        }
        if (beforeColse != null) {
          beforeColse(type);
          return;
        }
        hide();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            top: const BorderSide(
              width: 1,
              color: Color(0x1A000000),
            ),
            right: BorderSide(
              width: 1,
              color: type == 'cancel'
                  ? const Color(0x1A000000)
                  : Colors.transparent,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  /// 关闭 模态框
  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}

class $dialogSuccess {
  /// 点击确认
  bool confirm = false;

  /// 点击取消
  bool cancel = false;

  $dialogSuccess.fromJson(Map<String, dynamic> map) {
    confirm = map['confirm'];
    cancel = map['cancel'];
  }
}
