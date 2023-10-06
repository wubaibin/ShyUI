import 'package:flutter_face/ui/drop_down_menu/index.dart';

class DropDownMenuState {
  List<DropDownMenuModel> condition = [
    DropDownMenuModel(
      title: '排序方式',
      value: ['0'],
      type: DropDownMenuType.radio,
      required: true,
      param: 'order',
      data: [
        DropDownMenuItem(label: '时间正序', value: '0'),
        DropDownMenuItem(label: '时间倒序', value: '1'),
      ],
      icon: 'filter',
      isDropDown: false,
    ),
    DropDownMenuModel(
      title: '设备类型',
      value: [],
      type: DropDownMenuType.checkbox,
      required: false,
      param: 'deviceType',
      data: [
        DropDownMenuItem(label: '电池', value: 'B'),
        DropDownMenuItem(label: '换电柜', value: 'E'),
        DropDownMenuItem(label: '车辆', value: 'V'),
        DropDownMenuItem(label: 'NFC卡', value: 'R'),
      ],
    ),
    DropDownMenuModel(
      title: '创建时间',
      value: [],
      type: DropDownMenuType.radio,
      required: false,
      param: 'day',
      data: [
        DropDownMenuItem(label: '今日', value: '1'),
        DropDownMenuItem(label: '近三日', value: '3'),
        DropDownMenuItem(label: '近一周', value: '7'),
      ],
    ),
  ];
}
