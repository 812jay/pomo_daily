import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? margin;
  final Alignment alignment;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.margin = const EdgeInsets.symmetric(horizontal: 24),
    this.alignment = Alignment.centerRight,
    this.width,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: alignment,
      child: TextButton(
        style: ButtonStyle(
          minimumSize:
              width != null || height != null
                  ? WidgetStateProperty.all(Size(width ?? 0, height ?? 36))
                  : null,
          backgroundColor: WidgetStateProperty.all(context.colors.background),
          shadowColor: WidgetStateProperty.all(context.colors.border),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: context.colors.border),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: (textStyle ?? AppTextStyles.body1).copyWith(
            color: context.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
