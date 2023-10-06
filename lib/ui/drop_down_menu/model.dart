/// 筛选类型 radio 单选 checkbox 多选
enum DropDownMenuType { radio, checkbox }

/// 筛选条件
/// ```
/// [title] 标题
/// [value] 选中的条件
/// [type] 筛选类型 radio 单选 checkbox 多选
/// [required] 是否必选
/// [param] 参数名
/// [data] 条件
/// [icon] icon
/// [isDropDown] 是否展示下拉
/// [disabled] 是否禁用
/// ```
class DropDownMenuModel {
  late String title;
  late List<String> value;
  late DropDownMenuType type;
  late bool required;
  late String param;
  late List<DropDownMenuItem> data;
  late String icon;
  late bool isDropDown;
  late bool disabled;

  DropDownMenuModel({
    required this.title,
    required this.value,
    required this.type,
    required this.required,
    required this.param,
    required this.data,
    this.icon = "drop_down",
    this.isDropDown = true,
    this.disabled = false,
  });

  DropDownMenuModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'].cast<String>();
    type = _parseFilterType(json['type']);
    required = json['required'];
    param = json['param'];
    icon = json['icon'];
    isDropDown = json['isDropDown'];
    if (json['data'] != null) {
      data = <DropDownMenuItem>[];
      json['data'].forEach((v) {
        data.add(DropDownMenuItem.fromJson(v));
      });
    }
    disabled = json['disabled'];
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
    data['disabled'] = disabled;
    return data;
  }

  DropDownMenuType _parseFilterType(String type) {
    switch (type) {
      case 'radio':
        return DropDownMenuType.radio;
      case 'checkbox':
        return DropDownMenuType.checkbox;
      default:
        throw Exception('Invalid filter type');
    }
  }
}

class DropDownMenuItem {
  late String label;
  late String value;

  DropDownMenuItem({required this.label, required this.value});

  DropDownMenuItem.fromJson(Map<String, dynamic> json) {
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
