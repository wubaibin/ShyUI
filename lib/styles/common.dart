import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';

class CommonStyle {
  /// 阴影
  static List<BoxShadow> shadow({Offset offset = const Offset(0, 0)}) {
    return [
      BoxShadow(
        color: AppColor.primaryText.withOpacity(0.05),
        blurRadius: 12,
        offset: offset,
      )
    ];
  }

  static Widget secondaryText13(String value, {double top = 0}) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 13,
          color: AppColor.secondaryText,
        ),
      ),
    );
  }

  static const TextStyle secondaryText14 = TextStyle(
    fontSize: 14,
    color: AppColor.secondaryText,
  );

  static const TextStyle primaryText14 = TextStyle(
    fontSize: 14,
    color: AppColor.primaryText,
  );

  static const TextStyle primaryText15Bold = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColor.primaryText,
  );
}
