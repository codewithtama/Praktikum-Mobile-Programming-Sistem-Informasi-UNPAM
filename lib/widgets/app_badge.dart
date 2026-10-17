import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  const AppBadge({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primarySubtle;
    final text = textColor ?? AppColors.primary;

    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 2,
            vertical: AppSpacing.xs,
          ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: text),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
