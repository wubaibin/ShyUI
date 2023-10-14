import 'package:flutter/material.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/icon/index.dart';

enum CheckBoxDirection { horizontal, vertical }

class CheckBoxWidget extends StatefulWidget {
  final List<CheckboxModel> data;
  final List<dynamic> value;
  final ValueChanged<List<dynamic>>? onChanged;
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
  final CheckBoxDirection direction;
  final Color disabledColor;
  final int max;
  final int min;

  /// 复选框
  /// ```
  /// [data] 复选框数组
  /// [value] 复选框初始默认值
  /// [onChanged] 返回选中的value数组
  /// [disabled] 复选框全部禁用
  /// [iconSize] 复选框icon大小
  /// [spacing] 设置水平间距
  /// [runSpacing] 设置垂直间距
  /// [activeIcon] 复选框选中icon
  /// [activeColor] 复选框选中icon颜色
  /// [inactiveIcon] 复选框未选中icon
  /// [inactiveColor] 复选框未选中icon颜色
  /// [activeWidget] 自定义复选框选中Widget 可以是图片
  /// [inactiveWidget] 自定义复选框未选中Widget 可以是图片
  /// [labelSpace] 文字和icon的间距
  /// [labelFontSize] 文字字体大小
  /// [labelColor] 文字颜色
  /// [labelDisabled] 是否禁用单选框内容点击
  /// [direction] 复选框list排序方式
  ///             CheckBoxDirection.horizontal 是左右
  ///             CheckBoxDirection.vertical 是上下
  /// [disabledColor] 复选框禁用颜色
  /// [max] 设置最大可选数 默认是0 (不限)
  /// [min] 设置最小可选数 默认是0 (不限)
  /// ```
  const CheckBoxWidget({
    super.key,
    required this.data,
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.iconSize = 20,
    this.spacing = 18,
    this.runSpacing = 12,
    this.activeIcon = "checkbox_active",
    this.activeColor = AppColor.themeColor,
    this.inactiveIcon = "checkbox_inactive",
    this.inactiveColor = AppColor.threearyText,
    this.activeWidget,
    this.inactiveWidget,
    this.labelSpace = 8,
    this.labelFontSize = 18,
    this.labelColor = AppColor.primaryText,
    this.labelDisabled = false,
    this.direction = CheckBoxDirection.horizontal,
    this.disabledColor = AppColor.threearyText,
    this.max = 0,
    this.min = 0,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  late List<dynamic> _value;

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = List.from(widget.value);
    });
  }

  @override
  void didUpdateWidget(covariant CheckBoxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        _value = List.from(widget.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.direction == CheckBoxDirection.horizontal
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
    bool active = _value.contains(value);
    void setValue() {
      setState(() {
        if (active) {
          if (widget.min == 0 || widget.min < _value.length) {
            _value.remove(value);
          }
          return;
        }
        if (widget.max == 0 || widget.max > _value.length) {
          _value.add(value);
        }
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

class CheckboxModel {
  late String label;
  late dynamic value;
  late bool disabled;

  CheckboxModel({
    required this.label,
    required this.value,
    this.disabled = false,
  });

  CheckboxModel.fromJson(Map<String, dynamic> json) {
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
