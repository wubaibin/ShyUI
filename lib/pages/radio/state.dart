import 'package:flutter_face/ui/radio.dart';

class RadioState {
  List<RadioModel> baseList = [
    RadioModel(label: '单选框1', value: '1'),
    RadioModel(label: '单选框2', value: '2'),
    RadioModel(label: '单选框3', value: '3'),
  ];
  List<RadioModel> disableList = [
    RadioModel(label: '单选框1', value: '1'),
    RadioModel(label: '单选框2', value: '2', disabled: true),
    RadioModel(label: '单选框3', value: '3'),
  ];
}
