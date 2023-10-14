import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/ui/app_bar.dart';
import 'package:shy_ui/ui/drop_down_menu/index.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class DropDownMenuPage extends GetView<DropDownMenuController> {
  const DropDownMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DropDownMenuController>(
      builder: (_) {
        return Scaffold(
          appBar: const AppBarWidget(title: "DropDownMenu 下拉菜单"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DetailTitleWidget(title: '基础用法', top: 20),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white,
                  child: DropDownMenu(
                    data: _.state.condition,
                    onChanged: (value) {},
                  ),
                ),
                const DetailTitleWidget(title: '自定义颜色', top: 20),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white,
                  child: DropDownMenu(
                    data: _.state.condition,
                    activeBgColor: Colors.amber.withOpacity(0.1),
                    activeIconColor: Colors.amber,
                    activeMenuTextColor: Colors.amber,
                    activeTextColor: Colors.amber,
                    onChanged: (value) {},
                  ),
                ),
                const DetailTitleWidget(title: '禁用菜单', top: 20),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white,
                  child: DropDownMenu(
                    data: _.state.condition2,
                    onChanged: (value) {},
                  ),
                ),
                const DetailTitleWidget(title: '向上展开', top: 20),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white,
                  child: DropDownMenu(
                    data: _.state.condition,
                    direction: DropDownDirection.up,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
