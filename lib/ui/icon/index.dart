import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'name.dart';

class IconFont extends StatelessWidget {
  final String name;
  final double size;
  final Color color;

  /// iconfont 图标
  /// ```
  /// [name] 图标名称
  /// [color] 图标颜色
  /// [size] 图标大小
  /// ```
  const IconFont({
    Key? key,
    required this.name,
    this.size = 16,
    this.color = AppColor.themeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (name == '') {
      throw ArgumentError('name不能为空');
    }
    return Icon(
      iconName[name],
      size: size,
      color: color,
    );
  }
}
