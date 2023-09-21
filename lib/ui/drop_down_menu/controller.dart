import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/drop_down_menu/index.dart';
import 'package:flutter_face/ui/navigator_route.dart';
import 'package:get/get.dart';

class DropDownMenuController {
  static final BuildContext _context = Get.context!;
  static AnimationController? _controller;

  static void show({
    required double top,
    required double height,
    required double buttonHeight,
    Color overlyBgColor = AppColor.maskBgColor,
    int duration = 300,
    Function? onBgTap,
    required Widget child,
  }) {
    Navigator.push(
      _context,
      NavigatorRoute(
        bgColor: Colors.transparent,
        duration: duration,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              if (onBgTap != null) {
                onBgTap();
                return;
              }
              hide();
            },
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.transparent,
                ),
                Positioned.fill(
                  left: 0,
                  right: 0,
                  top: top,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: _AnimationChild(
                          duration: duration,
                          height: height,
                          buttonHeight: buttonHeight,
                          controller: (controller) {
                            _controller = controller;
                          },
                          child: child,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: overlyBgColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hide() {
    if (_controller != null) {
      _controller?.reverse();
    }
    Navigator.of(_context).pop();
    _controller = null;
  }

  /// 展示文案
  static String initTitle(DropDownMenuModel data) {
    List<String> value = data.value;
    if (value.isEmpty || data.type == DropDownMenuType.onPress) {
      return data.title;
    }
    String title = '';
    for (DropDownMenuItem item in data.data) {
      if (value.contains(item.value)) {
        title += '${item.label}/';
      }
    }
    title = title.substring(0, title.length - 1);
    if (title.length <= 4) {
      return title;
    }
    return title;
  }

  /// 获取条件
  static Map<String, dynamic> getCondition(List<DropDownMenuModel> data) {
    Map<String, dynamic> condition = {};
    for (DropDownMenuModel item in data) {
      if (item.value.isNotEmpty) {
        if (item.type == DropDownMenuType.checkbox) {
          List<String> stringList = [];
          for (String item in item.value) {
            stringList.add(item.toString());
          }
          condition[item.param] = stringList;
        } else {
          condition[item.param] = item.value.first;
        }
      }
    }
    return condition;
  }
}

class _AnimationChild extends StatefulWidget {
  final Widget child;
  final int duration;
  final double height;
  final double buttonHeight;
  final ValueChanged<AnimationController> controller;

  const _AnimationChild({
    required this.child,
    required this.duration,
    required this.height,
    required this.buttonHeight,
    required this.controller,
  });

  @override
  State<_AnimationChild> createState() => __AnimationChildState();
}

class __AnimationChildState extends State<_AnimationChild>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: widget.height).animate(controller);
    controller.forward();
    widget.controller(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => SizedBox(
        height: animation.value,
        child: animation.value >= widget.buttonHeight
            ? widget.child
            : const SizedBox(),
      ),
    );
  }
}
