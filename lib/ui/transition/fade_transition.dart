import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatefulWidget {
  final Widget child;
  final bool show;
  final int duration;
  const FadeTransitionWidget({
    super.key,
    required this.child,
    required this.show,
    this.duration = 1000,
  });

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant FadeTransitionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Visibility(
          visible: _animationController.status != AnimationStatus.dismissed,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
