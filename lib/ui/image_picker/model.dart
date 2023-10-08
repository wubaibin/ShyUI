/// 图片选择器的列表
/// ```
/// [value] 展示的图片路径
/// [deletable] 是否展示删除按钮
/// [preview] 是否参与预览
/// ```
class ImagePickerItem {
  late Object value;
  late bool deletable;
  late bool preview;

  ImagePickerItem({
    required this.value,
    this.deletable = true,
    this.preview = true,
  });

  ImagePickerItem.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    deletable = json['deletable'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['deletable'] = deletable;
    data['preview'] = preview;
    return data;
  }
}

/// 图片选择器的列表选项
/// ```
/// [deletable] 是否展示删除按钮
/// [preview] 是否参与预览
/// [add] 是否可以添加
/// ```
class ImagePickerItemOption {
  late bool deletable;
  late bool preview;
  late bool add;

  ImagePickerItemOption({
    this.deletable = true,
    this.preview = true,
    this.add = true,
  });

  ImagePickerItemOption.fromJson(Map<String, dynamic> json) {
    deletable = json['disabled'];
    preview = json['preview'];
    add = json['add'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disabled'] = deletable;
    data['preview'] = preview;
    data['add'] = add;
    return data;
  }
}
