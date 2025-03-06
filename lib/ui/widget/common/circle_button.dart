import 'package:flutter/material.dart';
import 'package:pomo_daily/theme/app_colors.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final bool outlined;

  const CircleButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 56.0,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            outlined
                ? Colors.transparent
                : (backgroundColor ?? AppColors.transparent),
        border:
            outlined
                ? Border.all(
                  color:  AppColors.borderGray,
                  width: 1,
                )
                : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size / 2),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
