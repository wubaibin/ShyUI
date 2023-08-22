/// 选项model
class OptionsModel {
  late String label;
  late dynamic value;

  OptionsModel({required this.label, required this.value});

  OptionsModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
