import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/tab_bar/index.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class TabBarPage extends GetView<TabBarController> {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabBarController>(
      builder: (_) {
        return StageWidget(
          title: "TabBar 标签页",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBarWidget(
                isScrollable: false,
                data: _.state.tabBaseList,
                controller: _.tabBaseController,
              ),
            ),
            const DetailTitleWidget(title: '带有数量', top: 20),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBarWidget(
                isScrollable: false,
                data: _.state.tabAccountList,
                controller: _.tabBaseController,
              ),
            ),
            const DetailTitleWidget(title: '标签栏滚动'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBarWidget(
                data: _.state.tabScrollList,
                controller: _.tabScrollController,
              ),
            ),
            const DetailTitleWidget(title: '样式风格'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TabBarWidget(
                isScrollable: false,
                data: _.state.tabBaseList,
                controller: _.tabBaseController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColor.themeColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColor.themeColor,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBarWidget(
                isScrollable: false,
                data: _.state.tabBaseList,
                controller: _.tabBaseController,
                indicator: const TabIndicator(
                  width: 28,
                  height: 3,
                  color: Colors.red,
                  radius: 10,
                  bottom: 4,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
