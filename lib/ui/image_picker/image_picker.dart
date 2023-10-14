import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:shy_ui/styles/index.dart';
import 'package:shy_ui/ui/icon/index.dart';
import 'package:shy_ui/ui/image_picker/preview_image.dart';
import 'package:shy_ui/ui/toast.dart';
import './choose_image.dart';
import 'index.dart';

class ImagePicker extends StatefulWidget {
  final List<ImagePickerItem>? data;
  final int maxCount;
  final int maxSize;
  final ValueChanged<List<ImagePickerItem>> onChanged;
  final Future<ImagePickerItemOption> Function(int index, File file)? beforeAdd;
  final Future<bool> Function(ImagePickerItem value, int index)? beforeRemove;
  final BoxFit imageFit;
  final bool preview;
  final bool compressed;
  final double spacing;
  final double runSpacing;
  final double width;
  final double height;
  final Color bgColor;
  final double borderRadius;
  final String icon;
  final double iconSize;
  final Color iconColor;
  final Widget? customIcon;
  final double clearPositionRight;
  final double clearPositionTop;
  final Widget? customClear;

  /// 图片选择器
  /// ```
  /// [data] 初始图片
  /// [maxCount] 图片上传数量限制
  /// [maxSize] 图片大小限制
  /// [onChanged] 图片发生改变时触发
  /// [beforeAdd] 添加图片前执行 用于改变图片是否可以再次编辑和预览
  /// [beforeRemove] 删除图片前执行 用于删除前可以向用户做出提示
  /// [imageFit] 图片剪裁、缩放的模式
  /// [preview] 是否可以预览
  /// [compressed] 图片是否压缩到maxSize大小
  /// [spacing] 多个图片左右间距
  /// [runSpacing] 多个图片上下间距
  /// [width] 上传图片容器的宽度
  /// [height] 上传图片容器的高度
  /// [bgColor] 上传图片容器的背景色
  /// [borderRadius] 上传图片容器的圆角
  /// [icon] 上传图片容器的icon
  /// [iconSize] 上传图片容器的icon大小
  /// [iconColor] 上传图片容器的icon颜色
  /// [customIcon] 自定义上传图片容器icon
  /// [clearPositionRight] 清除按钮的靠右的距离
  /// [clearPositionTop] 清除按钮的靠上的距离
  /// [customClear] 自定义清除按钮
  /// ```
  const ImagePicker({
    super.key,
    this.data,
    this.maxCount = 99,
    this.maxSize = 2,
    required this.onChanged,
    this.beforeAdd,
    this.beforeRemove,
    this.imageFit = BoxFit.cover,
    this.preview = true,
    this.compressed = false,
    this.spacing = 12,
    this.runSpacing = 12,
    this.width = 90,
    this.height = 90,
    this.bgColor = const Color(0xFFF4F6F8),
    this.borderRadius = 12,
    this.icon = 'photo',
    this.iconSize = 28,
    this.iconColor = const Color(0xFFCBCCD4),
    this.customIcon,
    this.clearPositionRight = 4,
    this.clearPositionTop = 4,
    this.customClear,
  });

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<ImagePickerItem> _list = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _list = widget.data ?? [];
    });
  }

  @override
  void didUpdateWidget(covariant ImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      setState(() {
        _list = widget.data ?? [];
      });
    }
  }

  void _addImage() async {
    final url = await ChooseImage.chooseMedia();
    if (url == null) {
      return;
    }
    File imageFile = File(url.path);
    ImagePickerItemOption option = ImagePickerItemOption();
    if (widget.beforeAdd != null) {
      option = await widget.beforeAdd!(_list.length, imageFile);
    }
    if (!option.add) {
      return;
    }
    bool isImage = ['.jpg', '.jpeg', '.png', '.gif'].any(
      (extension) => imageFile.path.toLowerCase().endsWith(extension),
    );
    if (!isImage) {
      $toast.showToast(title: "选取的文件不是图片");
      return;
    }
    int fileSize = await imageFile.length();
    if (fileSize / (1024 * 1024) > widget.maxSize) {
      if (!widget.compressed) {
        $toast.showToast(title: "图片大小不能大于${widget.maxSize}M");
        return;
      }
      final compressedFile = await _compressImage(imageFile, widget.maxSize);
      if (compressedFile == null) {
        return;
      }
      setState(() {
        _list.add(ImagePickerItem(
          value: compressedFile,
          preview: option.preview,
          deletable: option.deletable,
        ));
      });
      widget.onChanged(_list);
      return;
    }
    setState(() {
      _list.add(ImagePickerItem(
        value: imageFile,
        preview: option.preview,
        deletable: option.deletable,
      ));
    });
    widget.onChanged(_list);
  }

  void _removeImage(ImagePickerItem value, int index) async {
    if (widget.beforeRemove != null) {
      final isRemove = await widget.beforeRemove!(value, index);
      if (isRemove) {
        setState(() {
          _list.remove(value);
          widget.onChanged(_list);
        });
      }
      return;
    }
    setState(() {
      _list.remove(value);
      widget.onChanged(_list);
    });
  }

  Future<File?> _compressImage(File imageFile, int maxSize) async {
    $toast.showLoading(title: "图片压缩中...");
    int originalSize = await imageFile.length();
    int targetSize = maxSize * 1024 * 1024;
    Uint8List imageData = await imageFile.readAsBytes();
    ui.Image image = await decodeImageFromList(imageData);
    double ratio = 1;
    while (originalSize > targetSize && ratio > 0) {
      int targetWidth = (image.width * ratio).toInt();
      int targetHeight = (image.height * ratio).toInt();
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      canvas.drawImageRect(
        image,
        Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(0, 0, targetWidth.toDouble(), targetHeight.toDouble()),
        Paint(),
      );
      final compressedImage = await recorder.endRecording().toImage(
            targetWidth,
            targetHeight,
          );
      ByteData? byteData = await compressedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List compressedImageData = byteData!.buffer.asUint8List();
      originalSize = compressedImageData.lengthInBytes;
      ratio *= 0.9;
      if (originalSize <= targetSize) {
        Directory tempDir = Directory.systemTemp;
        String tempPath =
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_image.png';
        final compressedFile = File(tempPath);
        await compressedFile.writeAsBytes(compressedImageData);
        $toast.hideLoading();
        return compressedFile;
      }
    }
    $toast.showToast(title: "无法将图片压缩到${maxSize}M以下");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: [
        ..._list
            .asMap()
            .entries
            .map(
              (item) => Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.preview && item.value.preview) {
                        PreviewImage.show(data: _list, index: item.key);
                      }
                    },
                    child: _buildShowImage(item.value),
                  ),
                  if (item.value.deletable)
                    Positioned(
                      right: widget.clearPositionRight,
                      top: widget.clearPositionTop,
                      child: GestureDetector(
                        onTap: () {
                          _removeImage(item.value, item.key);
                        },
                        child: widget.customClear ??
                            Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: AppColor.maskBgColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.clear_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                      ),
                    ),
                ],
              ),
            )
            .toList(),
        if (_list.length < widget.maxCount)
          GestureDetector(
            onTap: () {
              _addImage();
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: widget.customIcon ??
                  IconFont(
                    name: widget.icon,
                    size: widget.iconSize,
                    color: widget.iconColor,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildShowImage(ImagePickerItem value) {
    final val = value.value;
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.bgColor,
        child: val is File
            ? Image.file(
                val,
                fit: widget.imageFit,
                width: widget.width,
                height: widget.height,
              )
            : val is String
                ? val.contains("http")
                    ? Image.network(
                        val,
                        fit: widget.imageFit,
                        width: widget.width,
                        height: widget.height,
                      )
                    : Image.asset(
                        val,
                        fit: widget.imageFit,
                        width: widget.width,
                        height: widget.height,
                      )
                : const SizedBox(),
      ),
    );
  }
}
