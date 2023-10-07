import 'package:flutter/material.dart';
import 'package:flutter_face/styles/index.dart';
import 'package:flutter_face/ui/icon/index.dart';

class NoticeBar extends StatefulWidget {
  final String? text;
  final int speed;
  final bool scrollable;
  final bool wrapable;
  final String? icon;
  final Color color;
  final double fontSize;
  final double iconSize;
  final Color? bgColor;
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final BorderRadius borderRadius;
  final Decoration? decoration;
  final Widget? child;
  final Function? onPress;

  /// 通知栏
  /// ```
  /// [text] 通知文本内容
  /// [speed] 滚动速率
  /// [scrollable] 是否开启滚动播放
  /// [wrapable] 是否开启文本换行，只在禁用滚动时生效
  /// [icon] 左侧图标
  /// [color] 通知文本颜色
  /// [fontSize] 通知文本内容字体大小
  /// [iconSize] 左侧图标大小
  /// [bgColor] 滚动条背景
  /// [height] 滚动条高度
  /// [padding] 滚动条内边距
  /// [textStyle] 自定义通知文本内容样式
  /// [leftIcon] 自定义左侧图标
  /// [rightIcon] 自定义右侧图标
  /// [borderRadius] 滚动条圆角
  /// [decoration] 自定义滚动条样式
  /// [child] 自定义滚动内容
  /// [onPress] 点击通知栏时触发
  /// ```
  const NoticeBar({
    super.key,
    this.text,
    this.speed = 10,
    this.scrollable = true,
    this.wrapable = false,
    this.icon,
    this.color = AppColor.themeColor,
    this.fontSize = 14,
    this.iconSize = 20,
    this.bgColor,
    this.height = 40,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.textStyle,
    this.leftIcon,
    this.rightIcon,
    this.borderRadius = BorderRadius.zero,
    this.decoration,
    this.child,
    this.onPress,
  });

  @override
  State<NoticeBar> createState() => _NoticeBarState();
}

class _NoticeBarState extends State<NoticeBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ScrollController _scrctrl;
  double _space = 0;

  @override
  void initState() {
    super.initState();

    _scrctrl = ScrollController();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.speed),
    );

    _animation = Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(_controller);
    _animation.addListener(() {
      if (_scrctrl.hasClients) {
        if (_scrctrl.position.hasContentDimensions) {
          var index = _animation.value / 100;
          _scrctrl.jumpTo(index * _scrctrl.position.maxScrollExtent);
        }
        if (_scrctrl.position.hasViewportDimension && _space == 0) {
          setState(() {
            _space = _scrctrl.position.viewportDimension;
          });
        }
      }
    });
    _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant NoticeBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollable != oldWidget.scrollable) {
      setState(() {
        _space = 0;
      });
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) {
          widget.onPress!();
        }
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: widget.height),
        padding: widget.padding,
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.bgColor ?? AppColor.themeColor.withOpacity(0.1),
              borderRadius: widget.borderRadius,
            ),
        child: Row(
          children: [
            if (widget.icon != null && widget.icon!.isNotEmpty)
              widget.leftIcon ??
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: IconFont(
                      name: widget.icon!,
                      size: widget.iconSize,
                      color: widget.color,
                    ),
                  ),
            Expanded(
              child: widget.scrollable
                  ? SingleChildScrollView(
                      controller: _scrctrl,
                      scrollDirection: Axis.horizontal,
                      child: _scrctrl.hasClients
                          ? Row(
                              children: [
                                SizedBox(width: _space),
                                widget.child ??
                                    Text(
                                      widget.text ?? '',
                                      style: widget.textStyle ??
                                          TextStyle(
                                            fontSize: widget.fontSize,
                                            color: widget.color,
                                          ),
                                    ),
                                SizedBox(width: _space),
                              ],
                            )
                          : const SizedBox(),
                    )
                  : Text(
                      widget.text ?? '',
                      style: widget.textStyle ??
                          TextStyle(
                            fontSize: widget.fontSize,
                            color: widget.color,
                          ),
                      maxLines: widget.wrapable ? null : 1,
                      overflow: widget.wrapable ? null : TextOverflow.ellipsis,
                    ),
            ),
            if (widget.rightIcon != null) widget.rightIcon!,
          ],
        ),
      ),
    );
  }
}
