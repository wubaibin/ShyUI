import 'package:flutter/material.dart';
import 'package:shy_ui/config/images.dart';
import 'package:shy_ui/styles/index.dart';

class EmptyWidget extends StatelessWidget {
  final String url;
  final double top;
  final String title;
  final TextStyle titleStyle;
  final double width;
  final double height;

  /// 空状态
  /// ```
  /// [url] 空状态图片路由
  /// [top] 距离上方距离
  /// [title] 文案
  /// [titleStyle] 自定义文案样式
  /// [width] 空状态图片宽度
  /// [height] 空状态图片高度
  /// ```
  const EmptyWidget({
    super.key,
    this.url = ImagesUrl.emptyNoData,
    this.top = 0,
    this.title = "暂无数据",
    this.titleStyle = const TextStyle(
      fontSize: 14,
      color: AppColor.threearyText,
    ),
    this.width = 120,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: top, bottom: 10),
            child: Image.asset(
              url,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Text(title, style: titleStyle),
        ],
      ),
    );
  }
}
