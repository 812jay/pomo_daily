import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double size;
  final Color? backgroundColor;
  final bool outlined;

  const CircleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.size = 48.0,
    this.backgroundColor,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.whiteColor,
        shape: BoxShape.circle,
        border:
            outlined ? Border.all(color: AppColors.borderGray, width: 1) : null,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size / 2),
          child: Center(child: child),
        ),
      ),
    );
  }
}
