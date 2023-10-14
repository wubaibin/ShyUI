import 'package:shy_ui/ui/checkbox.dart';

class CheckboxState {
  List<CheckboxModel> baseList = [
    CheckboxModel(label: '复选框1', value: '1'),
    CheckboxModel(label: '复选框2', value: '2'),
    CheckboxModel(label: '复选框3', value: '3'),
  ];
  List<CheckboxModel> disbaledList = [
    CheckboxModel(label: '复选框1', value: '1'),
    CheckboxModel(label: '复选框2', value: '2', disabled: true),
    CheckboxModel(label: '复选框3', value: '3'),
  ];
}
