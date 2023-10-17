import 'package:shy_ui/ui/popover/index.dart';

class PopoverState {
  List<PopoverItem> data = [
    PopoverItem(label: "气泡框1", value: "1"),
    PopoverItem(label: "气泡框2", value: "2"),
    PopoverItem(label: "气泡框3", value: "3"),
  ];

  List<PopoverItem> disabledData = [
    PopoverItem(label: "气泡框1", value: "1"),
    PopoverItem(label: "气泡框2", value: "2", disabled: true),
    PopoverItem(label: "气泡框3", value: "3"),
  ];
}
