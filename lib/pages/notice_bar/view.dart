import 'package:flutter/material.dart';
import 'package:shy_ui/components/detail_title.dart';
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/app_bar.dart';
import 'package:shy_ui/ui/notice_bar.dart';
import 'package:shy_ui/ui/toast.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class NoticeBarPage extends GetView<NoticeBarController> {
  const NoticeBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeBarController>(
      builder: (_) {
        return Scaffold(
          appBar: const AppBarWidget(title: "NoticeBar 通知栏"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 12),
                child: DetailTitleWidget(title: '基础用法', top: 20),
              ),
              const NoticeBar(
                icon: 'ic_lookingforcar',
                text: "在代码阅读过程中人们说脏话的频率是衡量代码质量的唯一标准。",
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 12),
                child: DetailTitleWidget(title: '滚动播放', top: 20),
              ),
              const NoticeBar(text: "在代码阅读过程中人们说脏话的频率是衡量代码质量的唯一标准。"),
              const SizedBox(height: 8),
              const NoticeBar(
                text: "在代码阅读过程中人们说脏话的频率是衡量代码质量的唯一标准。",
                scrollable: false,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 12),
                child: DetailTitleWidget(title: '多行展示', top: 20),
              ),
              const NoticeBar(
                text: "在代码阅读过程中人们说脏话的频率是衡量代码质量的唯一标准。",
                scrollable: false,
                wrapable: true,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 12),
                child: DetailTitleWidget(title: '自定义样式', top: 20),
              ),
              NoticeBar(
                icon: 'ic_help',
                text: "在代码阅读过程中人们说脏话的频率是衡量代码质量的唯一标准。",
                color: Colors.blue,
                bgColor: Colors.blue.withOpacity(0.1),
              ),
              const SizedBox(height: 8),
              NoticeBar(
                text: "技术是开发它的人的共同灵魂。",
                scrollable: false,
                rightIcon: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColor.themeColor,
                  ),
                ),
                onPress: () {
                  $toast.showToast(title: "点击了~~");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
