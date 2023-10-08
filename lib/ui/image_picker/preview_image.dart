import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_face/ui/image_picker/index.dart';
import 'package:flutter_face/utils/screen.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PreviewImage {
  static OverlayEntry? _overlayEntry;

  static void show({required List<ImagePickerItem> data, required int index}) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return PreviewImageWidget(
          data: data,
          index: index,
        );
      },
    );
    Navigator.of(Get.context!).overlay?.insert(_overlayEntry!);
  }

  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}

class PreviewImageWidget extends StatefulWidget {
  final List<ImagePickerItem> data;
  final int index;

  const PreviewImageWidget({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<PreviewImageWidget> createState() => _PreviewImageWidgetState();
}

class _PreviewImageWidgetState extends State<PreviewImageWidget> {
  late PageController pageController;
  List<ImagePickerItem> _list = [];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    final data = widget.data;
    final value = data[widget.index];
    final list = data.where((item) => item.preview == true).toList();
    final index = list.indexWhere((item) => item == value);

    setState(() {
      _list = list;
      _index = index;
    });
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          PreviewImage.hide();
        },
        child: Stack(
          children: [
            Container(
              width: Screen.width,
              height: Screen.height,
              color: Colors.black,
              alignment: Alignment.center,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: _buildImage(_list[index]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 6,
                    initialScale: PhotoViewComputedScale.contained * 1,
                  );
                },
                itemCount: _list.length,
                loadingBuilder: (context, progress) => const Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  ),
                ),
                pageController: pageController,
                onPageChanged: (value) {
                  setState(() {
                    _index = value;
                  });
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Screen.statusBar + 12,
              child: Text(
                "${_index + 1} / ${_list.length}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object>? _buildImage(ImagePickerItem value) {
    final val = value.value;
    if (val is File) {
      return FileImage(val);
    }
    if (val is String) {
      if (val.contains("http")) {
        return NetworkImage(val);
      }
      return AssetImage(val);
    }
    return null;
  }
}
