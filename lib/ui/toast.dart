import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_face/ui/icon/index.dart';
import 'package:flutter_face/utils/screen.dart';
import 'package:get/get.dart';

/// 消息提示框
/// ```
/// showLoading 和 showToast 同时只能显示一个
/// [showToast] 显示消息提示框
/// [showLoading] 显示 loading 提示框
/// [hideToast] 关闭消息提示框
/// [hideLoading] 关闭 loading 提示框
/// ```
class $toast {
  static OverlayEntry? _overlayEntry;

  static Timer? _time;

  static const Color _bgColor = Color.fromRGBO(0, 0, 0, 0.7);

  static const Color _color = Colors.white;

  /// 显示消息提示框
  /// ```
  /// [title] 提示的内容
  /// [icon] 显示图标
  /// [duration] 提示的延迟时间(毫秒)
  /// [mask] 是否显示透明蒙层，防止触摸穿透
  /// [maskClose] 是否点击透明蒙层关闭 当mask为false,maskClose失效
  /// [complete] 调用结束的回调函数
  /// ```
  static void showToast({
    required String title,
    String? icon,
    int duration = 3000,
    bool mask = true,
    bool maskClose = false,
    Function? complete,
  }) {
    if (_overlayEntry != null) {
      hideToast();
    }
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 0,
        bottom: 0,
        child: mask
            ? GestureDetector(
                onTap: () => maskClose ? hideToast() : {},
                child: Container(
                  width: Screen.width,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: _buildToastContainer(title: title, icon: icon),
                ),
              )
            : Container(
                width: Screen.width,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: _buildToastContainer(title: title, icon: icon),
              ),
      );
    });
    Navigator.of(Get.context!).overlay?.insert(_overlayEntry!);
    _time = Timer(Duration(milliseconds: duration), () {
      if (complete != null) {
        complete();
      }
      hideToast();
    });
  }

  /// 显示 loading 提示框。需主动调用 hideLoading 或 showToast 关闭提示框
  /// ```
  /// [title] 提示的内容 文本最多显示3行
  /// [mask] 是否显示透明蒙层，防止触摸穿透
  /// [maskClose] 是否点击透明蒙层关闭
  /// ```
  static void showLoading({
    required String title,
    bool mask = true,
    bool maskClose = false,
  }) {
    if (_overlayEntry != null) {
      hideToast();
    }
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 0,
        bottom: 0,
        child: mask
            ? GestureDetector(
                onTap: () {
                  if (maskClose) {
                    hideLoading();
                  }
                },
                child: Container(
                  width: Screen.width,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: _buildSizeContainer(title: title, loading: true),
                ),
              )
            : Container(
                width: Screen.width,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: _buildSizeContainer(title: title, loading: true),
              ),
      );
    });
    Navigator.of(Get.context!).overlay?.insert(_overlayEntry!);
  }

  static Widget _buildToastContainer({required String title, String? icon}) {
    if (icon != null) {
      return _buildSizeContainer(title: title, icon: icon);
    }
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: _color,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  // 创建icon和loading容器
  static Widget _buildSizeContainer({
    required String title,
    String? icon,
    bool loading = false,
  }) {
    return Container(
      width: 136,
      constraints: const BoxConstraints(minHeight: 136),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading
                ? const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  )
                : IconFont(name: icon!, color: _color, size: 36),
            Container(
              margin: const EdgeInsets.only(top: 28),
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _color,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 关闭消息提示框
  static void hideToast() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _time?.cancel();
    }
  }

  /// 关闭 loading 提示框
  static void hideLoading() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}
