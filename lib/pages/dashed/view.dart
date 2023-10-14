import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/dashed_container.dart';
import 'package:shy_ui/ui/dashed_line.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class DashedPage extends GetView<DashedController> {
  const DashedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashedController>(
      builder: (_) {
        return StageWidget(
          title: "Dashed 虚线和虚线容器",
          children: [
            _buildTitle('虚线'),
            const DetailTitleWidget(title: '基础用法'),
            const SizedBox(height: 12),
            const DashedLine(),
            const DetailTitleWidget(title: '自定义宽高'),
            const SizedBox(height: 12),
            const DashedLine(width: 200, height: 2),
            const DetailTitleWidget(title: '自定义间距和虚线宽度'),
            const SizedBox(height: 12),
            const DashedLine(width: 200, dashSpace: 12, dashWidth: 15),
            const DetailTitleWidget(title: '自定义颜色'),
            const SizedBox(height: 12),
            const DashedLine(width: 200, color: AppColor.themeColor),
            const DetailTitleWidget(title: '自定义方向'),
            const SizedBox(height: 12),
            const DashedLine(
              width: 1,
              height: 100,
              direction: DashedLineDirection.vertical,
            ),
            _buildTitle('虚线容器'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    DetailTitleWidget(title: '基础用法'),
                    SizedBox(height: 12),
                    DashedContainer(child: SizedBox(width: 50, height: 50)),
                  ],
                ),
                const Column(
                  children: [
                    DetailTitleWidget(title: '自定义颜色'),
                    SizedBox(height: 12),
                    DashedContainer(
                      color: AppColor.themeColor,
                      child: SizedBox(width: 50, height: 50),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const DetailTitleWidget(title: '自定义圆角'),
                    const SizedBox(height: 12),
                    DashedContainer(
                      borderRadius: BorderRadius.circular(12),
                      child: const SizedBox(width: 50, height: 50),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    DetailTitleWidget(title: '间距和虚线宽度'),
                    SizedBox(height: 12),
                    DashedContainer(
                      dashWidth: 10,
                      dashSpace: 12,
                      strokeWidth: 3,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColor.primaryText,
        ),
      ),
    );
  }
}
