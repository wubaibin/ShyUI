import 'package:flutter/material.dart';
import 'package:flutter_face/config/images.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:get/get.dart';

import 'index.dart';
// import 'widgets/widgets.dart';

class UserPage extends GetView<UserController> {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      id: "user",
      init: UserController(),
      builder: (_) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagesUrl.logo, width: 96, height: 76),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 6),
                  child: Text(
                    "Flutter Face",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryText,
                    ),
                  ),
                ),
                const Text(
                  "生活就是面对微笑",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.themeColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "当前版本 v1.0.0",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.threearyText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
