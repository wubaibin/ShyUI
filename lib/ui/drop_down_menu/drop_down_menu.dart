import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/drop_down_menu/controller.dart';
import 'package:flutter_face/ui/drop_down_menu/menu.dart';
import 'package:flutter_face/ui/drop_down_menu/model.dart';
import 'package:flutter_face/ui/icon/index.dart';

class DropDownMenu extends StatefulWidget {
  final List<DropDownMenuModel> data;
  final bool isScrollable;
  final ValueChanged<List<DropDownMenuModel>>? onChanged;
  final ValueChanged<Map<String, dynamic>>? onChangedParams;
  final double spacing;
  final double menuItemWidth;
  final double buttonHeight;
  final double menuListHeight;
  final double maxScrollHeight;
  final Widget Function(DropDownMenuModel data, bool active)? customDropDown;
  final Widget Function(String label, bool active, bool hideLine)?
      customMenuList;
  final Widget Function(Function resetTap, Function submitTap)?
      customMenuButton;

  /// 下拉菜单
  /// ```
  /// [data] 数据
  /// [isScrollable] 是否滚动
  /// [onChanged] 改变时触发
  /// [onChangedParams] 改变时触发 会返回处理好的params
  /// [spacing] 列表单个的间距
  /// [menuItemWidth] 列表单个的宽度
  /// [buttonHeight] 下拉按钮的高度
  /// [menuListHeight] 下拉列表的高度
  /// [maxScrollHeight] 下拉列表最高高度，溢出变为滚动
  /// [customDropDown] 自定义下拉按钮
  /// [customMenuList] 自定义下拉列表
  /// [customMenuButton] 自定义下拉按钮
  /// ```
  const DropDownMenu({
    super.key,
    required this.data,
    this.isScrollable = true,
    this.onChanged,
    this.onChangedParams,
    this.spacing = 8,
    this.menuItemWidth = 100,
    this.buttonHeight = 52,
    this.menuListHeight = 44,
    this.maxScrollHeight = 500,
    this.customDropDown,
    this.customMenuList,
    this.customMenuButton,
  });

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu>
    with TickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late List<DropDownMenuModel> _data;
  int? _index;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didUpdateWidget(covariant DropDownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    initData();
  }

  void initData() {
    List data = json.decode(json.encode(widget.data));
    setState(() {
      _data = data.map((item) => DropDownMenuModel.fromJson(item)).toList();
    });
  }

  void dropDownItemTap({required int index, required DropDownMenuModel data}) {
    if (data.type == DropDownMenuType.onPress) {
      setState(() {
        _data[index].value = data.value.isEmpty ? [data.param] : [];
      });
      return;
    }
    final list = data.data;
    if (list.isEmpty) {
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
    final height = disponseHeight(data);
    DropDownMenuController.show(
      top: top.dy + size.height,
      height: height,
      buttonHeight: widget.buttonHeight,
      onBgTap: hideDropDownMenu,
      child: MenuWidget(
        data: data,
        height: height,
        menuListHeight: widget.menuListHeight,
        buttonHeight: widget.buttonHeight,
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

  double disponseHeight(DropDownMenuModel data) {
    double height = data.data.length * widget.menuListHeight +
        (data.type == DropDownMenuType.radio ? 0 : widget.buttonHeight);
    return height >= widget.maxScrollHeight ? widget.maxScrollHeight : height;
  }

  double disponseItemWidth(double width) {
    return widget.isScrollable
        ? widget.menuItemWidth
        : (width - (_data.length - 1) * widget.spacing) / _data.length;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
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
                          ? widget.customDropDown!(e.value, _index == e.key)
                          : _buildItemContainer(
                              width: disponseItemWidth(width),
                              data: e.value,
                              active: _index == e.key,
                              isLast: e.key == _data.length - 1,
                            ),
                    ))
                .toList(),
          ),
        ),
      );
    });
  }

  Widget _buildItemContainer({
    required double width,
    required DropDownMenuModel data,
    required bool active,
    required bool isLast,
  }) {
    bool select = data.value.isNotEmpty || active;
    return Container(
      width: width,
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      margin: EdgeInsets.only(right: isLast ? 0 : widget.spacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: select ? AppColor.themeColor.withOpacity(0.1) : AppColor.bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              DropDownMenuController.initTitle(data),
              style: TextStyle(
                fontSize: 12,
                color: select ? AppColor.themeColor : AppColor.secondaryText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (data.icon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: IconFont(
                name: data.icon,
                size: 10,
                color: select ? AppColor.themeColor : AppColor.placeholderText,
              ),
            )
        ],
      ),
    );
  }
}
