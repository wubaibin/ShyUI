import 'package:flutter/material.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/icon/index.dart';

enum RadioDirection { horizontal, vertical }

class RadioWidget extends StatefulWidget {
  final List<RadioModel> data;
  final dynamic value;
  final ValueChanged<dynamic>? onChanged;
  final bool disabled;
  final double iconSize;
  final double spacing;
  final double runSpacing;
  final String activeIcon;
  final Color activeColor;
  final String inactiveIcon;
  final Color inactiveColor;
  final Widget? activeWidget;
  final Widget? inactiveWidget;
  final double labelSpace;
  final bool labelDisabled;
  final double labelFontSize;
  final Color labelColor;
  final RadioDirection direction;
  final Color disabledColor;

  /// 单选框
  /// ```
  /// [data] 单选框数组
  /// [value] 单选框初始默认值
  /// [onChanged] 返回选中的value数组
  /// [disabled] 单选框全部禁用
  /// [iconSize] 单选框icon大小
  /// [spacing] 设置水平间距
  /// [runSpacing] 设置垂直间距
  /// [activeIcon] 单选框选中icon
  /// [activeColor] 单选框选中icon颜色
  /// [inactiveIcon] 单选框未选中icon
  /// [inactiveColor] 单选框未选中icon颜色
  /// [activeWidget] 自定义单选框选中Widget 可以是图片
  /// [inactiveWidget] 自定义单选框未选中Widget 可以是图片
  /// [labelSpace] 文字和icon的间距
  /// [labelFontSize] 文字字体大小
  /// [labelColor] 文字颜色
  /// [labelDisabled] 是否禁用单选框内容点击
  /// [direction] 单选框list排序方式
  ///             RadioDirection.horizontal 是左右
  ///             RadioDirection.vertical 是上下
  /// [disabledColor] 单选框禁用颜色
  /// ```
  const RadioWidget({
    super.key,
    required this.data,
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.iconSize = 20,
    this.spacing = 18,
    this.runSpacing = 12,
    this.activeIcon = "radio_active",
    this.activeColor = AppColor.themeColor,
    this.inactiveIcon = "radio_inactive",
    this.inactiveColor = AppColor.threearyText,
    this.activeWidget,
    this.inactiveWidget,
    this.labelSpace = 8,
    this.labelFontSize = 18,
    this.labelColor = AppColor.primaryText,
    this.labelDisabled = false,
    this.direction = RadioDirection.horizontal,
    this.disabledColor = AppColor.threearyText,
  });

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  dynamic _value;

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.value;
    });
  }

  @override
  void didUpdateWidget(covariant RadioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        _value = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.direction == RadioDirection.horizontal
        ? Wrap(
            spacing: widget.spacing,
            runSpacing: widget.runSpacing,
            children: widget.data
                .asMap()
                .entries
                .map(
                  (item) => IntrinsicWidth(
                    child: _buildItem(
                      label: item.value.label,
                      value: item.value.value,
                      disabled: item.value.disabled,
                      index: item.key,
                    ),
                  ),
                )
                .toList(),
          )
        : Column(
            children: widget.data
                .asMap()
                .entries
                .map(
                  (item) => Padding(
                    padding: EdgeInsets.only(
                      top: item.key == 0 ? 0 : widget.runSpacing,
                    ),
                    child: _buildItem(
                      label: item.value.label,
                      value: item.value.value,
                      disabled: item.value.disabled,
                      index: item.key,
                    ),
                  ),
                )
                .toList(),
          );
  }

  Widget _buildItem({
    required String label,
    required dynamic value,
    required bool disabled,
    required int index,
  }) {
    bool active = _value == value;
    void setValue() {
      setState(() {
        if (active) {
          return;
        }
        _value = value;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_value);
      }
    }

    Widget buildIcon() {
      return widget.activeWidget == null || widget.inactiveWidget == null
          ? IconFont(
              name: active ? widget.activeIcon : widget.inactiveIcon,
              size: widget.iconSize,
              color: disabled || widget.disabled
                  ? widget.disabledColor
                  : active
                      ? widget.activeColor
                      : widget.inactiveColor,
            )
          : active
              ? widget.activeWidget!
              : widget.inactiveWidget!;
    }

    return GestureDetector(
      onTap: () {
        if (widget.labelDisabled || disabled || widget.disabled) {
          return;
        }
        setValue();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            widget.labelDisabled && !(disabled || widget.disabled)
                ? GestureDetector(
                    onTap: () {
                      setValue();
                    },
                    child: buildIcon(),
                  )
                : buildIcon(),
            Padding(
              padding: EdgeInsets.only(left: widget.labelSpace),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: widget.labelFontSize,
                  color: disabled || widget.disabled
                      ? widget.disabledColor
                      : widget.labelColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  late String label;
  late dynamic value;
  late bool disabled;

  RadioModel({
    required this.label,
    required this.value,
    this.disabled = false,
  });

  RadioModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    disabled = json['disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['disabled'] = disabled;
    return data;
  }
}
