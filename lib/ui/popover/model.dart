/// 弹出框的列表
/// ```
/// [value] 值
/// [label] 文案
/// [disabled] 是否禁用
/// ```
class PopoverItem {
  late dynamic value;
  late String label;
  late bool disabled;

  PopoverItem({
    required this.value,
    required this.label,
    this.disabled = false,
  });

  PopoverItem.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    disabled = json['disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    data['disabled'] = disabled;
    return data;
  }
}

class PopoverPosition {
  double? left;
  double? right;
  double? top;
  double? bottom;

  PopoverPosition({this.left, this.right, this.top, this.bottom});

  PopoverPosition.fromJson(Map<String, dynamic> json) {
    left = json['left'];
    right = json['right'];
    top = json['top'];
    bottom = json['bottom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['left'] = left;
    data['right'] = right;
    data['top'] = top;
    data['bottom'] = bottom;
    return data;
  }
}

class DotPosition {
  late double left;
  late double top;
  late double angle;

  DotPosition({required this.left, required this.top, required this.angle});

  DotPosition.fromJson(Map<String, dynamic> json) {
    left = json['left'];
    top = json['top'];
    angle = json['angle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['left'] = left;
    data['top'] = top;
    data['angle'] = angle;
    return data;
  }
}
