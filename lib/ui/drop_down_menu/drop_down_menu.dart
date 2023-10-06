import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/drop_down_menu/controller.dart';
import 'package:flutter_face/ui/drop_down_menu/menu.dart';
import 'package:flutter_face/ui/drop_down_menu/model.dart';
import 'package:flutter_face/ui/icon/index.dart';
import 'package:flutter_face/utils/screen.dart';

enum DropDownDirection { up, down }

class DropDownMenu extends StatefulWidget {
  final List<DropDownMenuModel> data;
  final DropDownDirection direction;
  final bool isScrollable;
  final ValueChanged<List<DropDownMenuModel>>? onChanged;
  final ValueChanged<Map<String, dynamic>>? onChangedParams;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final double buttonHeight;
  final double menuListHeight;
  final double maxScrollHeight;
  final Widget Function(DropDownMenuModel data, int index, bool active)?
      customDropDown;
  final Widget Function(String label, bool active, bool hideLine)?
      customMenuList;
  final Widget Function(Function resetTap, Function submitTap)?
      customMenuButton;
  final Color activeTextColor;
  final Color inacticeTextColor;
  final Color disabledTextColor;
  final Color? activeBgColor;
  final Color inactiveBgColor;
  final Color disabledBgColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color disabledIconColor;
  final Color activeMenuTextColor;
  final Color inactiveMenuTextColor;
  final Color lineColor;
  final Color overlyBgColor;
  final bool locked;

  /// 下拉菜单
  /// ```
  /// [data] 数据
  /// [direction] 方向
  /// [isScrollable] 是否滚动
  /// [onChanged] 改变时触发
  /// [onChangedParams] 改变时触发 会返回处理好的params
  /// [width] 宽度
  /// [height] 高度
  /// [padding] 间距
  /// [spacing] 左右间距
  /// [buttonHeight] 下拉按钮的高度
  /// [menuListHeight] 下拉列表的高度
  /// [maxScrollHeight] 下拉列表最高高度，溢出变为滚动
  /// [customDropDown] 自定义下拉按钮
  /// [customMenuList] 自定义下拉列表
  /// [customMenuButton] 自定义下拉按钮
  /// [activeTextColor] 选中文字颜色
  /// [inacticeTextColor] 未选中文字颜色
  /// [disabledTextColor] 禁用文字颜色
  /// [activeBgColor] 选中背景颜色
  /// [inactiveBgColor] 未选中背景颜色
  /// [disabledBgColor] 禁用背景颜色
  /// [activeIconColor] 选中icon颜色
  /// [inactiveIconColor] 未选中icon颜色
  /// [disabledIconColor] 禁用icon颜色
  /// [activeMenuTextColor] 选中列表文字颜色
  /// [inactiveMenuTextColor] 未选中列表文字颜色
  /// [lineColor] 横线颜色
  /// [overlyBgColor] 蒙版颜色
  /// [locked] 点击背景是否关闭
  /// ```
  const DropDownMenu({
    super.key,
    required this.data,
    this.direction = DropDownDirection.down,
    this.isScrollable = true,
    this.onChanged,
    this.onChangedParams,
    this.width = 82,
    this.height = 26,
    this.padding = const EdgeInsets.symmetric(horizontal: 9),
    this.spacing = 8,
    this.buttonHeight = 52,
    this.menuListHeight = 44,
    this.maxScrollHeight = 500,
    this.customDropDown,
    this.customMenuList,
    this.customMenuButton,
    this.activeTextColor = AppColor.themeColor,
    this.inacticeTextColor = AppColor.secondaryText,
    this.disabledTextColor = AppColor.placeholderText,
    this.activeBgColor,
    this.inactiveBgColor = AppColor.bgColor,
    this.disabledBgColor = AppColor.bgColor,
    this.activeIconColor = AppColor.themeColor,
    this.inactiveIconColor = AppColor.placeholderText,
    this.disabledIconColor = AppColor.placeholderText,
    this.activeMenuTextColor = AppColor.themeColor,
    this.inactiveMenuTextColor = AppColor.primaryText,
    this.lineColor = AppColor.bgColor,
    this.overlyBgColor = AppColor.maskBgColor,
    this.locked = false,
  });

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu>
    with TickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late List<DropDownMenuModel> _data;
  int? _index;
  late double _width;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void didUpdateWidget(covariant DropDownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initData();
  }

  void _initData() {
    List data = json.decode(json.encode(widget.data));
    setState(() {
      _data = data.map((item) => DropDownMenuModel.fromJson(item)).toList();
      _width = widget.width;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_key.currentContext != null) {
        final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
        setState(() {
          _width = widget.isScrollable
              ? widget.width
              : (renderBox.size.width - (_data.length - 1) * widget.spacing) /
                  _data.length;
        });
      }
    });
  }

  void dropDownItemTap({required int index, required DropDownMenuModel data}) {
    final list = data.data;
    if (list.isEmpty || data.disabled) {
      return;
    }
    if (!data.isDropDown) {
      final value = list
          .where((e) => e.label != DropDownMenuController.initTitle(data))
          .toList()[0];
      setState(() {
        _data[index].value = [value.value];
      });
      return;
    }
    setState(() {
      _index = index;
    });
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final top = renderBox.localToGlobal(Offset.zero);
    final height = _disponseHeight(data);
    DropDownMenuController.show(
      direction: widget.direction,
      distance: widget.direction == DropDownDirection.down
          ? top.dy + size.height
          : Screen.height - top.dy,
      height: height,
      buttonHeight: widget.buttonHeight,
      overlyBgColor: widget.overlyBgColor,
      onBgTap: () {
        if (!widget.locked) {
          hideDropDownMenu();
        }
      },
      child: MenuWidget(
        data: data,
        height: height,
        menuListHeight: widget.menuListHeight,
        buttonHeight: widget.buttonHeight,
        activeMenuTextColor: widget.activeMenuTextColor,
        inactiveMenuTextColor: widget.inactiveMenuTextColor,
        lineColor: widget.lineColor,
        customMenuList: widget.customMenuList,
        customMenuButton: widget.customMenuButton,
        submitTap: (value) {
          hideDropDownMenu();
          setState(() {
            _data[index].value = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(_data);
          }
          if (widget.onChangedParams != null) {
            widget.onChangedParams!(DropDownMenuController.getCondition(_data));
          }
        },
      ),
    );
  }

  void hideDropDownMenu() {
    setState(() {
      _index = null;
    });
    DropDownMenuController.hide();
  }

  double _disponseHeight(DropDownMenuModel data) {
    double height = data.data.length * widget.menuListHeight +
        (data.type == DropDownMenuType.radio ? 0 : widget.buttonHeight);
    return height >= widget.maxScrollHeight ? widget.maxScrollHeight : height;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _data
              .asMap()
              .entries
              .map((e) => GestureDetector(
                    onTap: () {
                      dropDownItemTap(index: e.key, data: e.value);
                    },
                    child: widget.customDropDown != null
                        ? widget.customDropDown!(
                            e.value,
                            e.key,
                            _index == e.key,
                          )
                        : _buildItemContainer(
                            data: e.value,
                            active: _index == e.key,
                            index: e.key,
                          ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildItemContainer({
    required DropDownMenuModel data,
    required bool active,
    required int index,
  }) {
    bool select = data.value.isNotEmpty || active;
    return Container(
      width: _width,
      height: widget.height,
      padding: widget.padding,
      margin: EdgeInsets.only(right: widget.spacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: select
            ? (widget.activeBgColor ?? AppColor.themeColor.withOpacity(0.1))
            : data.disabled
                ? widget.disabledBgColor
                : widget.inactiveBgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              DropDownMenuController.initTitle(data),
              style: TextStyle(
                fontSize: 12,
                color: select
                    ? widget.activeTextColor
                    : data.disabled
                        ? widget.disabledTextColor
                        : widget.inacticeTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (data.icon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Transform.rotate(
                angle: widget.direction == DropDownDirection.down
                    ? (index == _index ? pi : 0)
                    : index == _index
                        ? 0
                        : pi,
                child: IconFont(
                  name: data.icon,
                  size: 10,
                  color: select
                      ? widget.activeIconColor
                      : data.disabled
                          ? widget.disabledIconColor
                          : widget.inactiveIconColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}
