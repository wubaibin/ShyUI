import 'package:flutter/material.dart';
import 'package:flutter_face/config/images.dart';
import 'package:flutter_face/styles/index.dart';

class EmptyWidget extends StatelessWidget {
  final String url;
  final String title;
  final double top;
  final double scale;
  final TextStyle titleStyle;
  const EmptyWidget({
    super.key,
    this.url = ImagesUrl.emptyNoData,
    this.top = 0,
    this.title = "暂无数据",
    this.scale = 1,
    this.titleStyle = const TextStyle(
      fontSize: 14,
      color: AppColor.threearyText,
    ),
  });

  @override
  Widget build(BuildContext context) {
    double width = 120.0 * scale;
    double height = 100 * scale;
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
