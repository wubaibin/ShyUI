import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/ui/app_bar.dart';
import 'package:shy_ui/ui/popover/popover.dart';
import 'package:shy_ui/utils/screen.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class PopoverPage extends GetView<PopoverController> {
  const PopoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopoverController>(
      builder: (_) {
        return Scaffold(
          appBar: const AppBarWidget(title: "Popover 气泡框"),
          body: Container(
            width: Screen.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DetailTitleWidget(title: '基础用法', top: 20),
                const SizedBox(height: 8),
                Popover(
                  data: _.state.data,
                  child: _buildTextContainer("基础用法"),
                ),
                const DetailTitleWidget(title: '自定义方向', top: 20),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Popover(
                      data: _.state.data,
                      placement: Placement.top,
                      child: _buildTextContainer("上方"),
                    ),
                    const SizedBox(width: 12),
                    Popover(
                      data: _.state.data,
                      placement: Placement.right,
                      child: _buildTextContainer("右边"),
                    ),
                    const SizedBox(width: 12),
                    Popover(
                      data: _.state.data,
                      placement: Placement.left,
                      child: _buildTextContainer("左边"),
                    ),
                  ],
                ),
                const DetailTitleWidget(title: '禁用', top: 20),
                const SizedBox(height: 8),
                Popover(
                  data: _.state.disabledData,
                  child: _buildTextContainer("禁用"),
                ),
                const DetailTitleWidget(title: '选中', top: 20),
                const SizedBox(height: 8),
                Popover(
                  data: _.state.data,
                  value: '1',
                  child: _buildTextContainer("选中"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextContainer(String text) {
    return Container(
      width: 80,
      height: 40,
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}
