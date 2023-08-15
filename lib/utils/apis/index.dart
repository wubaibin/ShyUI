import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_face/utils/apis/popup_list.dart';
import 'package:flutter_face/ui/dialog.dart';
import 'package:flutter_face/ui/toast.dart';
import 'package:flutter_face/utils/storage.dart';
import 'package:permission_handler/permission_handler.dart';

class AppApi {
  /// 拍摄或从手机相册中选择图片
  static Future<XFile?> chooseMedia() async {
    List<Map<String, String>> list = [
      {'title': '拍照'.tr, 'key': 'camera'},
      {'title': '从手机相册选择'.tr, 'key': 'photo'},
      {'title': '取消'.tr, 'key': 'cancel'}
    ];
    final Completer<XFile?> completer = Completer();
    PopupList.show(
      list: list,
      onTap: (key) async {
        if (key == 'cancel') {
          completer.complete(null);
          return;
        }
        if (key == 'photo') {
          final PermissionStatus photoStatus =
              await Permission.photos.request();
          if (photoStatus.isDenied) {
            completer.complete(null);
            $dialog.show(
              content: '您未同意使用相册权限，请前往设置中进行设置'.tr,
              confirmText: '去设置'.tr,
              success: (value) {
                if (value.confirm) {
                  openAppSettings();
                }
              },
            );
            return;
          }
        }
        if (key == 'camera') {
          final PermissionStatus cameraStatus =
              await Permission.camera.request();
          if (cameraStatus.isDenied) {
            completer.complete(null);
            $dialog.show(
              content: '您未同意使用相机权限，请前往设置中进行设置'.tr,
              confirmText: '去设置'.tr,
              success: (value) {
                if (value.confirm) {
                  openAppSettings();
                }
              },
            );
            return;
          }
        }
        completer.complete(await ImagePicker().pickImage(
          source: key == 'photo' ? ImageSource.gallery : ImageSource.camera,
        ));
      },
    );
    return await completer.future;
  }

  /// 切换语言
  static lang() {
    List<Map<String, String>> list = [
      {'title': '中文'.tr, 'key': 'zh_CN'},
      {'title': '英文'.tr, 'key': 'en_US'},
      {'title': '取消'.tr, 'key': 'cancel'}
    ];
    PopupList.show(
      list: list,
      onTap: (value) async {
        if (value == 'cancel') {
          return;
        }
        final locale = value == 'zh_CN'
            ? const Locale('zh', 'CN')
            : const Locale('en', 'US');
        Get.updateLocale(locale);
        await Storage().set('lang', value);
        $toast.showToast(title: "切换语言成功".tr, icon: 'success');
      },
    );
  }
}
