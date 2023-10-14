import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/components/stage.dart';
import 'package:shy_ui/ui/textarea.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class TextareaPage extends GetView<TextareaController> {
  const TextareaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextareaController>(
      builder: (_) {
        return StageWidget(
          title: "Textarea 多行输入框",
          children: [
            const DetailTitleWidget(title: '基础用法', top: 20),
            const SizedBox(height: 8),
            _buildTextareaContainer(child: Textarea(onChanged: (value) {})),
            const DetailTitleWidget(title: '可以自动聚焦'),
            const SizedBox(height: 8),
            _buildTextareaContainer(
              child: Textarea(
                autofocus: true,
                onChanged: (value) {},
              ),
            ),
            const DetailTitleWidget(title: '改变最大输入值'),
            const SizedBox(height: 8),
            _buildTextareaContainer(
              child: Textarea(
                maxLength: 100,
                onChanged: (value) {},
              ),
            ),
            const DetailTitleWidget(title: '隐藏下方数字'),
            const SizedBox(height: 8),
            _buildTextareaContainer(
              child: Textarea(
                showCounter: false,
                onChanged: (value) {},
              ),
            ),
            const DetailTitleWidget(title: '改变占位符颜色和数字颜色'),
            const SizedBox(height: 8),
            _buildTextareaContainer(
              child: Textarea(
                placeholderStyle: const TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  color: Colors.red,
                ),
                counterStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextareaContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
