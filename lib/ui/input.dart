import 'dart:async';

import 'package:flutter_face/styles/index.dart';
import 'package:flutter/material.dart';

/// 输入框
class Input extends StatefulWidget {
  final String value;
  final TextInputType? type;
  final bool password;
  final String placeholder;
  final bool disabled;
  final TextAlign textAlign;
  final int? maxLength;
  final bool autofocus;
  final TextInputAction? confirmType;
  final bool clear;
  final EdgeInsetsGeometry? clearPadding;
  final TextStyle? style;
  final TextStyle? placeholderStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onBlur;
  final ValueChanged<String>? onFocus;
  final ValueChanged<double>? keyboardHeightChange;
  final bool throttle;
  final int throttleTime;

  /// 输入框
  /// ```
  /// [value] 输入框的初始内容
  /// [type] input 的类型
  /// [password] 是否是密码类型
  /// [placeholder] 输入框为空时占位符
  /// [disabled] 是否禁用
  /// [textAlign] 输入文本靠哪边
  /// [maxLength] 最大输入长度
  /// [autofocus] 自动聚焦
  /// [confirmType] 设置键盘右下角按钮的文字
  /// [clear] 是否展示清除图标
  /// [style] 指定 value 的样式
  /// [placeholderStyle] 指定 placeholder 的样式
  /// [onChanged] 键盘输入时触发
  /// [onSubmitted] 点击完成按钮时触发
  /// [onFocus] 输入框聚焦时触发
  /// [onBlur] 输入框失去焦点时触发
  /// [keyboardHeightChange] 键盘高度发生变化的时候触发此事件
  /// [throttle] 是否开启节流
  /// [throttleTime] 节流时间
  /// ```
  const Input({
    super.key,
    this.value = "",
    this.type = TextInputType.text,
    this.password = false,
    required this.placeholder,
    this.disabled = false,
    this.maxLength = 50,
    this.textAlign = TextAlign.left,
    this.autofocus = false,
    this.confirmType = TextInputAction.done,
    this.clear = true,
    this.clearPadding = const EdgeInsets.fromLTRB(6, 0, 15, 0),
    this.style = const TextStyle(
      color: AppColor.primaryText,
      fontSize: 15,
      height: 1.2,
    ),
    this.placeholderStyle = const TextStyle(
      color: AppColor.placeholderText,
      fontSize: 15,
      height: 1.2,
    ),
    this.onChanged,
    this.onSubmitted,
    this.onBlur,
    this.onFocus,
    this.keyboardHeightChange,
    this.throttle = false,
    this.throttleTime = 500,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  Timer? _timer;
  final TextEditingController _controller = TextEditingController(text: "");
  final FocusNode _focusNode = FocusNode();

  String inputValue = "";
  double keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    initValue();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (widget.keyboardHeightChange != null) {
          widget.keyboardHeightChange!(
            MediaQuery.of(context).viewInsets.bottom,
          );
        }
        if (widget.onFocus != null) {
          widget.onFocus!(inputValue);
        }
      }
      if (!_focusNode.hasFocus) {
        if (widget.keyboardHeightChange != null) {
          widget.keyboardHeightChange!(0);
        }
        if (widget.onBlur != null) {
          widget.onBlur!(inputValue);
        }
      }
    });
  }

  void initValue() {
    _controller.text = widget.value;
    _controller.selection = TextSelection.fromPosition(TextPosition(
      offset: widget.value.length,
    ));
    setState(() {
      inputValue = widget.value;
    });
  }

  /// 键盘输入时触发
  void onChanged(String value) {
    if (widget.onChanged != null) {
      if (widget.throttle) {
        _timer = Timer(Duration(milliseconds: widget.throttleTime), () {
          widget.onChanged!(value);
        });
      } else {
        widget.onChanged!(value);
      }
    }
    setState(() {
      inputValue = value;
    });
  }

  /// 点击完成按钮时触发
  void onSubmitted(value) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(value);
    }
  }

  /// 清除
  void clearTap() {
    if (widget.onChanged != null) {
      widget.onChanged!("");
    }
    _controller.clear();
    setState(() {
      inputValue = "";
    });
  }

  @override
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      initValue();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            enabled: !widget.disabled,
            maxLength: widget.maxLength,
            keyboardType: widget.type,
            textInputAction: widget.confirmType,
            autofocus: widget.autofocus,
            obscureText: widget.password,
            style: widget.style,
            cursorColor: AppColor.themeColor,
            textAlign: widget.textAlign,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.placeholder,
              counterText: "",
              contentPadding: EdgeInsets.zero,
              hintStyle: widget.placeholderStyle,
              isCollapsed: true,
            ),
          ),
        ),
        inputValue == "" || !widget.clear
            ? Container()
            : GestureDetector(
                onTap: () {
                  clearTap();
                },
                child: Container(
                  padding: widget.clearPadding,
                  child: const Icon(
                    Icons.cancel_rounded,
                    size: 18,
                    color: Color(0xFFB6B6B8),
                  ),
                ),
              ),
      ],
    );
  }
}
