/// 工作台
class WorkbenchListModel {
  late String title;
  late List<WorkbenchItem> value;

  WorkbenchListModel({required this.title, required this.value});

  WorkbenchListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    json['value'].forEach((v) {
      value.add(WorkbenchItem.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value.map((v) => v.toJson()).toList();
    return data;
  }
}

class WorkbenchItem {
  late String title;
  late String image;
  late String url;
  late bool show;

  WorkbenchItem({
    required this.title,
    required this.image,
    required this.url,
    required this.show,
  });

  WorkbenchItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    url = json['url'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['url'] = url;
    data['show'] = show;
    return data;
  }
}
