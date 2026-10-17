import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'animated_pressable.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isPrimary;
  final bool isLoading;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Widget childContent = isLoading
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
            ],
          );

    final buttonWidget = isPrimary
        ? ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            child: childContent,
          )
        : OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            child: childContent,
          );

    final wrapped = width != null
        ? SizedBox(width: width, child: buttonWidget)
        : buttonWidget;

    if (onPressed != null && !isLoading) {
      return AnimatedPressable(
        scaleDown: 0.96,
        onTap: onPressed,
        child: wrapped,
      );
    }

    return wrapped;
  }
}
