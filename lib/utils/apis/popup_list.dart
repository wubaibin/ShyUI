import 'package:flutter/material.dart';
import 'package:flutter_face/ui/button.dart';
import 'package:flutter_face/ui/popup.dart';
import 'package:flutter_face/utils/common.dart';
import 'package:flutter_face/utils/screen.dart';

class PopupList {
  static show({
    required List<Map<String, String>> list,
    ValueChanged<String>? onTap,
  }) {
    double bottom = Screen.bottomBar;
    $popup.show(
      safeArea: false,
      clear: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: list.asMap().entries.map((e) {
          return Column(
            children: [
              Button(
                title: e.value['title'] ?? '',
                height: 52 + (e.key == list.length - 1 ? bottom : 0),
                shape: ButtonShape.square,
                size: ButtonSize.large,
                color: const Color(0xFF1A1A1A),
                bgColor: Colors.white,
                fontSize: 16,
                padding: e.key == list.length - 1
                    ? EdgeInsets.only(bottom: bottom)
                    : null,
                borderRadius: e.key == 0
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      )
                    : null,
                onPress: Common.throttle(() async {
                  $popup.hide();
                  if (onTap != null) {
                    onTap(e.value['key'] ?? "");
                  }
                }),
              ),
              Container(
                width: double.infinity,
                height: e.key == list.length - 1
                    ? 0
                    : e.key == list.length - 2
                        ? 6
                        : 1,
                color: e.key == list.length - 2
                    ? const Color(0xFFF7F7F7)
                    : const Color(0xFFEAEAEA),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
