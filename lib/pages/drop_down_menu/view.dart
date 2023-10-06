import 'package:flutter/material.dart';
import 'package:flutter_face/ui/app_bar.dart';
import 'package:flutter_face/ui/drop_down_menu/index.dart';
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
          body: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.white,
            child: DropDownMenu(
              data: _.state.condition,
              onChanged: (value) {},
            ),
          ),
        );
      },
    );
  }
}
