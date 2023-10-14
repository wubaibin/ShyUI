import 'package:shy_ui/ui/image_picker/model.dart';

class ImagePickerState {
  List<ImagePickerItem> previewList = [
    ImagePickerItem(value: "https://img01.yzcdn.cn/vant/leaf.jpg"),
    ImagePickerItem(value: "https://img01.yzcdn.cn/vant/tree.jpg"),
  ];

  List<ImagePickerItem> maxCountList = [
    ImagePickerItem(value: "https://img01.yzcdn.cn/vant/sand.jpg"),
  ];

  List<ImagePickerItem> deletableList = [
    ImagePickerItem(
      value: "https://img01.yzcdn.cn/vant/sand.jpg",
      deletable: false,
    ),
  ];
}
