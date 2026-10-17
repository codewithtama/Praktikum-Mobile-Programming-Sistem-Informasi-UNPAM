import 'package:flutter/material.dart';

class PulsingGlow extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const PulsingGlow({
    super.key,
    required this.child,
    this.glowColor = const Color(0x330F766E),
    this.minScale = 0.96,
    this.maxScale = 1.04,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<PulsingGlow> createState() => _PulsingGlowState();
}

class _PulsingGlowState extends State<PulsingGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ));

    _glowAnimation = Tween<double>(
      begin: 6.0,
      end: 22.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor,
                blurRadius: _glowAnimation.value,
                spreadRadius: _glowAnimation.value / 4,
              ),
            ],
          ),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
