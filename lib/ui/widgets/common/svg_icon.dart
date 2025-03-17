import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    this.onTap,
    required this.iconName,
    this.size = 10.0,
    this.iconColor = AppColors.textPrimary,
  });
  final GestureTapCallback? onTap;
  final String iconName;
  final double? size;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/$iconName.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}
