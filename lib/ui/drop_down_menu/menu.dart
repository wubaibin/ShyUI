import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shy_ui/ui/button.dart';
import 'package:shy_ui/ui/drop_down_menu/index.dart';
import 'package:shy_ui/ui/icon/index.dart';

class MenuWidget extends StatefulWidget {
  final DropDownMenuModel data;
  final double height;
  final double buttonHeight;
  final double menuListHeight;
  final ValueChanged<List<String>> submitTap;
  final Widget Function(String label, bool active, bool hideLine)?
      customMenuList;
  final Widget Function(Function resetTap, Function submitTap)?
      customMenuButton;
  final Color activeMenuTextColor;
  final Color inactiveMenuTextColor;
  final Color lineColor;

  const MenuWidget({
    super.key,
    required this.data,
    required this.height,
    required this.buttonHeight,
    required this.menuListHeight,
    required this.submitTap,
    required this.activeMenuTextColor,
    required this.inactiveMenuTextColor,
    required this.lineColor,
    this.customMenuList,
    this.customMenuButton,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late List<String> _value;

  @override
  void initState() {
    super.initState();
    String jsonString = json.encode(widget.data.value);
    setState(() {
      _value = List<String>.from(json.decode(jsonString));
    });
  }

  void listTap(bool active, String value) {
    final data = widget.data;
    if (active) {
      if (data.required) {
        return;
      }
      setState(() {
        _value.remove(value);
      });
      if (data.type == DropDownMenuType.radio) {
        widget.submitTap(_value);
      }
      return;
    }
    if (data.type == DropDownMenuType.radio) {
      setState(() {
        _value.clear();
        _value.add(value);
      });
      widget.submitTap(_value);
      return;
    }
    setState(() {
      _value.add(value);
    });
  }

  resetTap() {
    setState(() {
      _value.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.data;
    final type = widget.data.type;
    return Container(
      height: widget.height,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: data.asMap().entries.map(
                  (item) {
                    final active = _value.contains(item.value.value);
                    return GestureDetector(
                      onTap: () {
                        listTap(active, item.value.value);
                      },
                      child: widget.customMenuList != null
                          ? widget.customMenuList!(
                              item.value.label,
                              active,
                              item.key == data.length - 1,
                            )
                          : _buildMenuItemContainer(
                              label: item.value.label,
                              active: active,
                              hideLine: item.key == data.length - 1,
                            ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          if (type == DropDownMenuType.checkbox)
            widget.customMenuButton != null
                ? SizedBox(
                    width: double.infinity,
                    height: widget.buttonHeight,
                    child: widget.customMenuButton!(() {
                      resetTap();
                    }, () {
                      widget.submitTap(_value);
                    }),
                  )
                : Container(
                    width: double.infinity,
                    height: widget.buttonHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Button(
                            size: ButtonSize.large,
                            title: '重置',
                            height: 36,
                            plain: true,
                            onPress: resetTap,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Button(
                            size: ButtonSize.large,
                            title: '确定',
                            height: 36,
                            onPress: () {
                              widget.submitTap(_value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
        ],
      ),
    );
  }

  Widget _buildMenuItemContainer({
    required String label,
    required bool active,
    required bool hideLine,
  }) {
    return Container(
      height: widget.menuListHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
            bottom: hideLine
                ? BorderSide.none
                : BorderSide(color: widget.lineColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: active
                    ? widget.activeMenuTextColor
                    : widget.inactiveMenuTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (active)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconFont(
                name: "success",
                size: 16,
                color: widget.activeMenuTextColor,
              ),
            ),
        ],
      ),
    );
  }
}
