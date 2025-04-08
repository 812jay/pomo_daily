import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.iconPrimary,
    required this.iconSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.background,
    required this.border,
    required this.completedDot,
    required this.uncompletedDot,
    required this.error,
    required this.dialogBackground,
    required this.dialogBarrier,
  });

  final Color iconPrimary;
  final Color iconSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color background;
  final Color border;
  final Color completedDot;
  final Color uncompletedDot;
  final Color error;
  final Color dialogBackground;
  final Color dialogBarrier;
  // 라이트 테마용 색상
  static const light = CustomColors(
    iconPrimary: AppColors.iconPrimary,
    iconSecondary: AppColors.iconSecondary,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    background: AppColors.backgroundColor,
    border: AppColors.borderGray,
    completedDot: AppColors.completedDotColor,
    uncompletedDot: AppColors.uncompletedDotColor,
    error: AppColors.error,
    dialogBackground: AppColors.dialogBackground,
    dialogBarrier: AppColors.dialogBarrierLight,
  );

  // 다크 테마용 색상
  static const dark = CustomColors(
    iconPrimary: AppColors.iconPrimaryDark,
    iconSecondary: AppColors.iconSecondaryDark,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    background: AppColors.backgroundColorDark,
    border: AppColors.borderGray,
    completedDot: AppColors.completedDotColorDark,
    uncompletedDot: AppColors.uncompletedDotColorDark,
    error: AppColors.error,
    dialogBackground: AppColors.dialogBackgroundDark,
    dialogBarrier: AppColors.dialogBarrierDark,
  );

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? iconPrimary,
    Color? iconSecondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? background,
    Color? border,
    Color? completedDot,
    Color? uncompletedDot,
    Color? error,
    Color? dialogBackground,
    Color? dialogBarrier,
  }) {
    return CustomColors(
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      background: background ?? this.background,
      border: border ?? this.border,
      completedDot: completedDot ?? this.completedDot,
      uncompletedDot: uncompletedDot ?? this.uncompletedDot,
      error: error ?? this.error,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      dialogBarrier: dialogBarrier ?? this.dialogBarrier,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
    ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) return this;
    return CustomColors(
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      border: Color.lerp(border, other.border, t)!,
      completedDot: Color.lerp(completedDot, other.completedDot, t)!,
      uncompletedDot: Color.lerp(uncompletedDot, other.uncompletedDot, t)!,
      error: Color.lerp(error, other.error, t)!,
      dialogBackground:
          Color.lerp(dialogBackground, other.dialogBackground, t)!,
      dialogBarrier: Color.lerp(dialogBarrier, other.dialogBarrier, t)!,
    );
  }
}

// 편의를 위한 확장 메서드
extension CustomColorsExtension on BuildContext {
  CustomColors get colors => Theme.of(this).extension<CustomColors>()!;
}
