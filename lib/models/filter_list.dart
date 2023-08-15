/// 筛选类型 radio 单选 checkbox 多选
enum FilterType { radio, checkbox }

/// 筛选条件
/// ```
/// [title] 标题
/// [value] 选中的条件
/// [type] 筛选类型 radio 单选 checkbox 多选
/// [required]
/// [param] 参数名
/// [data] 条件
/// [icon] icon
/// [isDropDown] 是否展示下拉
/// ```
class FilterListModel {
  late String title;
  late List<String> value;
  late FilterType type;
  late bool required;
  late String param;
  late List<FilterItem> data;
  late String icon;
  late bool isDropDown;

  FilterListModel({
    required this.title,
    required this.value,
    required this.type,
    required this.required,
    required this.param,
    required this.data,
    this.icon = "drop_down",
    this.isDropDown = true,
  });

  FilterListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'].cast<String>();
    type = _parseFilterType(json['type']);
    required = json['required'];
    param = json['param'];
    icon = json['icon'];
    isDropDown = json['isDropDown'];
    if (json['data'] != null) {
      data = <FilterItem>[];
      json['data'].forEach((v) {
        data.add(FilterItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    data['type'] = type.toString().split('.').last;
    data['required'] = required;
    data['param'] = param;
    data['icon'] = icon;
    data['isDropDown'] = isDropDown;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }

  FilterType _parseFilterType(String type) {
    switch (type) {
      case 'radio':
        return FilterType.radio;
      case 'checkbox':
        return FilterType.checkbox;
      default:
        throw Exception('Invalid filter type');
    }
  }
}

class FilterItem {
  late String label;
  late String value;

  FilterItem({required this.label, required this.value});

  FilterItem.fromJson(Map<String, dynamic> json) {
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
