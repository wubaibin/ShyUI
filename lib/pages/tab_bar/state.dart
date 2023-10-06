import 'package:flutter_face/ui/tab_bar/index.dart';

class TabBarState {
  List<TabBarModel> tabBaseList = [
    TabBarModel(label: '标签 1', value: '1'),
    TabBarModel(label: '标签 2', value: '2'),
    TabBarModel(label: '标签 3', value: '3'),
    TabBarModel(label: '标签 4', value: '4'),
  ];

  List<TabBarModel> tabScrollList = [
    TabBarModel(label: '标签 1', value: '1'),
    TabBarModel(label: '标签 2', value: '2'),
    TabBarModel(label: '标签 3', value: '3'),
    TabBarModel(label: '标签 4', value: '4'),
    TabBarModel(label: '标签 5', value: '5'),
    TabBarModel(label: '标签 6', value: '6'),
    TabBarModel(label: '标签 7', value: '7'),
    TabBarModel(label: '标签 8', value: '8'),
  ];

  List<TabBarModel> tabAccountList = [
    TabBarModel(label: '标签 1', value: '1', count: 0),
    TabBarModel(label: '标签 2', value: '2', count: 11),
    TabBarModel(label: '标签 3', value: '3', count: 80),
    TabBarModel(label: '标签 4', value: '4', count: 100),
  ];
}
