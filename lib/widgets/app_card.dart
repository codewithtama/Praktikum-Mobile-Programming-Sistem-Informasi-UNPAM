import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'animated_pressable.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Border? border;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark ? AppColors.cardDark : AppColors.card;
    final defaultBorder = Border.all(
      color: isDark ? AppColors.borderDark : AppColors.border,
      width: 1,
    );
    final radius = BorderRadius.circular(borderRadius ?? AppRadius.lg);

    Widget content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBg,
        borderRadius: radius,
        border: border ?? defaultBorder,
        boxShadow: boxShadow ?? (isDark ? [] : AppShadows.card),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          splashColor: (isDark ? Colors.white : AppColors.primary).withAlpha(20),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return AnimatedPressable(
        onTap: onTap,
        scaleDown: 0.97,
        child: content,
      );
    }

    return content;
  }
}
