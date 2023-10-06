/// TabBar
/// ```
/// [label] 文案
/// [value] 值
/// [account] 数量
/// [dot] 显示圆点徽标
/// ```
class TabBarModel {
  late String label;
  late dynamic value;
  int? count;
  bool? dot;

  TabBarModel({required this.label, required this.value, this.count, this.dot});

  TabBarModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    count = json['count'];
    dot = json['dot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['count'] = count;
    data['dot'] = dot;
    return data;
  }
}
