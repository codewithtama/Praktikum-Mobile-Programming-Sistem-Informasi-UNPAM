import 'package:flutter/material.dart';

class AnimatedPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleDown;
  final Duration duration;

  const AnimatedPressable({
    super.key,
    required this.child,
    this.onTap,
    this.scaleDown = 0.96,
    this.duration = const Duration(milliseconds: 120),
  });

  @override
  State<AnimatedPressable> createState() => _AnimatedPressableState();
}

class _AnimatedPressableState extends State<AnimatedPressable> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null ? null : (_) => setState(() => _isPressed = true),
      onTapUp: widget.onTap == null ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: widget.onTap == null ? null : () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? widget.scaleDown : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
