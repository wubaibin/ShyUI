import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/touchable_highlight.dart';
import 'package:get/get.dart';

import '../index.dart';

class ListWidget extends GetView<HomeController> {
  final String title;
  final String url;
  const ListWidget({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "home",
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: TouchableHighlight(
            width: double.infinity,
            height: 40,
            borderRadius: BorderRadius.circular(50),
            onPress: () {
              _.goToDetailPage(url);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF323233),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: AppColor.placeholderText,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
