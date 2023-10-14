import 'package:flutter/material.dart';
import 'package:shy_ui/styles/index.dart';

class DetailTitleWidget extends StatelessWidget {
  final String title;
  final double top;

  /// 详情页的标题
  const DetailTitleWidget({super.key, required this.title, this.top = 32});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(title, style: CommonStyle.secondaryText14),
    );
  }
}
