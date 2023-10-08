import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_face/ui/button.dart';
import 'package:flutter_face/ui/dialog.dart';
import 'package:flutter_face/ui/popup.dart';
import 'package:flutter_face/utils/common.dart';
import 'package:flutter_face/utils/screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ChooseImage {
  static Future<XFile?> chooseMedia() async {
    List<Map<String, String>> list = [
      {'title': '拍照', 'key': 'camera'},
      {'title': '从手机相册选择', 'key': 'photo'},
      {'title': '取消', 'key': 'cancel'}
    ];
    final Completer<XFile?> completer = Completer();
    _popupShowList(
      list: list,
      onTap: (key) async {
        if (key == 'cancel') {
          completer.complete(null);
          return;
        }
        if (key == 'photo') {
          final permission = await _photoPermission();
          if (!permission) {
            completer.complete(null);
            $dialog.show(
              content: '您未同意使用相册权限，请前往设置中进行设置',
              confirmText: '去设置',
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
          final permission = await _cameraPermission();
          if (!permission) {
            completer.complete(null);
            $dialog.show(
              content: '您未同意使用相机权限，请前往设置中进行设置',
              confirmText: '去设置',
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

  static _popupShowList({
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
                size: ButtonSize.long,
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

  static Future<bool> _photoPermission() async {
    if (Platform.isIOS) {
      final request = await Permission.photos.request();
      if (request.isDenied) {
        return false;
      }
      return true;
    }
    PermissionStatus photos = await Permission.photos.status;
    PermissionStatus storage = await Permission.storage.status;
    if (storage.isGranted || photos.isGranted) {
      return true;
    }
    if (storage.isDenied || photos.isDenied) {
      PermissionStatus storageStatus = await Permission.storage.request();
      PermissionStatus photosStatus = await Permission.photos.request();
      if (storageStatus.isGranted || photosStatus.isGranted) {
        return true;
      }
      return false;
    }
    return false;
  }

  static Future<bool> _cameraPermission() async {
    if (Platform.isIOS) {
      final request = await Permission.camera.request();
      if (request.isDenied) {
        return false;
      }
      return true;
    }
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      PermissionStatus requestedStatus = await Permission.camera.request();
      if (requestedStatus.isGranted) {
        return true;
      }
      return false;
    }
    return false;
  }
}
