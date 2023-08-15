import 'package:flutter_face/styles/color.dart';
import 'package:flutter/material.dart';

class Textarea extends StatefulWidget {
  final String value;
  final String placeholder;
  final bool disabled;
  final int? maxLength;
  final int? maxLines;
  final bool autofocus;
  final TextInputAction? confirmType;
  final TextStyle? style;
  final TextStyle? placeholderStyle;
  final TextStyle? counterStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// 多行输入框
  /// ```
  /// [value] 输入框的内容
  /// [placeholder] 输入框为空时占位符
  /// [disabled] 是否禁用
  /// [maxlength] 最大输入长度
  /// [maxLines] 输入框的最大行数
  /// [autofocus] 自动聚焦，拉起键盘
  /// [confirmType] 设置键盘右下角按钮的文字
  /// [style] 指定 value 的样式
  /// [placeholderStyle] 指定 placeholder 的样式
  /// [onChanged] 键盘输入时触发
  /// [onSubmitted] 点击完成按钮时触发
  /// ```
  const Textarea({
    super.key,
    this.value = "",
    this.placeholder = '请详细描述您需要备注的内容',
    this.disabled = false,
    this.maxLength = 50,
    this.maxLines = 4,
    this.autofocus = false,
    this.confirmType = TextInputAction.done,
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
    this.counterStyle = const TextStyle(
      fontSize: 12,
      color: AppColor.placeholderText,
    ),
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<Textarea> createState() => _TextareaState();
}

class _TextareaState extends State<Textarea> {
  final TextEditingController _controller = TextEditingController(text: "");
  String inputValue = "";

  @override
  void initState() {
    super.initState();
    initValue();
  }

  void initValue() {
    _controller.text = widget.value;
    setState(() {
      inputValue = widget.value;
    });
  }

  /// 键盘输入时触发
  void onChanged(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
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

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: !widget.disabled,
      keyboardType: TextInputType.multiline,
      textInputAction: widget.confirmType,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      autofocus: widget.autofocus,
      style: widget.style,
      cursorColor: AppColor.themeColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.placeholder,
        contentPadding: EdgeInsets.zero,
        counterStyle: widget.counterStyle,
        hintStyle: widget.placeholderStyle,
        isCollapsed: true,
      ),
    );
  }
}
