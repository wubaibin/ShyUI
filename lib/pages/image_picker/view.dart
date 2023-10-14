import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/ui/app_bar.dart';
import 'package:shy_ui/ui/image_picker/index.dart';
import 'package:shy_ui/ui/toast.dart';
import 'package:shy_ui/utils/screen.dart';
import 'package:get/get.dart';

import 'index.dart';

class ImagePickerPage extends GetView<ImagePickerController> {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const AppBarWidget(title: "ImagePicker 图片选择器"),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, Screen.bottomBar),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DetailTitleWidget(title: '基础用法', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(onChanged: (value) {}),
                  const DetailTitleWidget(title: '图片预览', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    data: _.state.previewList,
                    onChanged: (value) {},
                  ),
                  const DetailTitleWidget(title: '限制上传数量', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    data: _.state.maxCountList,
                    maxCount: 3,
                    onChanged: (value) {},
                  ),
                  const DetailTitleWidget(title: '限制上传大小', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    data: _.state.maxCountList,
                    maxSize: 2,
                    onChanged: (value) {},
                  ),
                  const DetailTitleWidget(title: '默认图片禁止删除', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    data: _.state.deletableList,
                    maxCount: 2,
                    onChanged: (value) {},
                  ),
                  const DetailTitleWidget(title: '图片过大压缩至maxSize大小', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    compressed: true,
                    maxSize: 2,
                    onChanged: (value) {},
                  ),
                  const DetailTitleWidget(title: '上传前置处理', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    beforeAdd: (index, file) async {
                      bool isPng = ['.png'].any((extension) =>
                          file.path.toLowerCase().endsWith(extension));
                      if (!isPng) {
                        $toast.showToast(title: "请上传png格式的图片");
                        return ImagePickerItemOption(add: false);
                      }
                      return ImagePickerItemOption();
                    },
                    onChanged: (value) {},
                  ),
                  const DetailTitleWidget(title: '删除前置处理', top: 20),
                  const SizedBox(height: 12),
                  ImagePicker(
                    data: _.state.maxCountList,
                    maxCount: 2,
                    beforeRemove: (value, index) async {
                      return await _.removeImage();
                    },
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
