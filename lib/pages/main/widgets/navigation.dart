import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shy_ui/config/index.dart';
import 'package:shy_ui/styles/color.dart';
import 'package:shy_ui/ui/icon/index.dart';

import '../index.dart';

class NavigationWidget extends GetView<MainController> {
  final ValueChanged<int> onIndexChanged;
  const NavigationWidget({
    Key? key,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      id: "main",
      builder: (_) {
        return BottomAppBar(
          color: AppColor.bottomBarBgColor,
          child: Container(
            height: Config.bottomAppBarHeight,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryText.withOpacity(0.02),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: Row(
              children: _.state.bottomBarItems.asMap().entries.map(
                (e) {
                  final index = e.key;
                  final value = e.value;
                  final isSelect = (index == _.state.index);
                  final color = isSelect
                      ? AppColor.themeColor
                      : AppColor.bottomBarUnselectColor;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onIndexChanged(index);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: IconFont(
                                    name: isSelect
                                        ? value.selectIcon
                                        : value.unselectIcon,
                                    size: 20,
                                    color: color,
                                  ),
                                ),
                                if (value.count != 0) _buildDot(value.count),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                value.label.tr,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDot(int count) {
    return Positioned(
      left: 11,
      top: 1,
      child: Container(
        height: 18,
        constraints: const BoxConstraints(minWidth: 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: AppColor.errorColor,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          '${count > 99 ? '99+' : count}',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
