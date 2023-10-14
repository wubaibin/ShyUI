import 'package:flutter/material.dart';
import 'package:shy_ui/ui/drop_down_menu/index.dart';
import 'package:shy_ui/ui/navigator_route.dart';
import 'package:shy_ui/utils/screen.dart';
import 'package:get/get.dart';

class DropDownMenuController {
  static final BuildContext _context = Get.context!;
  static AnimationController? _controller;

  static void show({
    required double distance,
    required DropDownDirection direction,
    required double height,
    required double buttonHeight,
    required Color overlyBgColor,
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
                  width: Screen.width,
                  height: Screen.height,
                  color: Colors.transparent,
                ),
                if (direction == DropDownDirection.down)
                  Positioned.fill(
                    left: 0,
                    right: 0,
                    top: distance,
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
                        ),
                      ],
                    ),
                  ),
                if (direction == DropDownDirection.up)
                  Positioned.fill(
                    left: 0,
                    right: 0,
                    bottom: distance,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: overlyBgColor,
                          ),
                        ),
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

  static String initTitle(DropDownMenuModel data) {
    List<String> value = data.value;
    if (value.isEmpty) {
      return data.title;
    }
    String title = '';
    for (DropDownMenuItem item in data.data) {
      if (value.contains(item.value)) {
        title += '${item.label}/';
      }
    }
    return title.substring(0, title.length - 1);
  }

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
