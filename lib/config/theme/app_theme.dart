import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      extensions: [CustomColors.light],
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.light(primary: AppColors.primaryColor),

      // 텍스트 테마
      textTheme: TextTheme(
        // Headline 스타일
        displayLarge: AppTextStyles.headline1,
        displayMedium: AppTextStyles.headline2,
        displaySmall: AppTextStyles.headline3,

        // Body 스타일
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,

        // Caption 스타일
        labelMedium: AppTextStyles.caption1,
        labelSmall: AppTextStyles.caption2,
      ),

      // 앱바 테마
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        titleTextStyle: AppTextStyles.headline1.copyWith(
          color: AppColors.backgroundColor,
          fontSize: 20,
        ),
      ),

      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // 카드 테마
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // 다크 테마 정의
  static ThemeData get darkTheme {
    return ThemeData(
      extensions: [CustomColors.dark],
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColorDark,
      scaffoldBackgroundColor: AppColors.backgroundColorDark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryColorDark,
        surface: AppColors.backgroundColorDark,
        onSurface: AppColors.textPrimaryDark,
        secondary: AppColors.textSecondaryDark,
      ),

      // 텍스트 테마
      textTheme: TextTheme(
        // Headline 스타일
        displayLarge: AppTextStyles.headline1.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: AppTextStyles.headline2.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: AppTextStyles.headline3.copyWith(
          color: AppColors.textPrimaryDark,
        ),

        // Body 스타일
        bodyLarge: AppTextStyles.body1.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: AppTextStyles.body2.copyWith(
          color: AppColors.textPrimaryDark,
        ),

        // Caption 스타일
        labelMedium: AppTextStyles.caption1.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelSmall: AppTextStyles.caption2.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),

      // 앱바 테마
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundColorDark,
        elevation: 0,
        titleTextStyle: AppTextStyles.headline1.copyWith(
          color: AppColors.textPrimaryDark,
          fontSize: 20,
        ),
      ),

      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColorDark,
          foregroundColor: AppColors.textPrimaryDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // 카드 테마
      cardTheme: CardTheme(
        color: AppColors.backgroundColorDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.borderGray),
        ),
      ),

      // 입력 필드 테마
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.backgroundColorDark,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryColorDark),
        ),
      ),

      // 아이콘 테마
      iconTheme: IconThemeData(color: AppColors.iconPrimaryDark),

      // 스위치 테마
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColorDark;
          }
          return AppColors.textSecondaryDark;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColorDark;
          }
          return AppColors.borderGray;
        }),
      ),

      // 슬라이더 테마
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryColorDark,
        inactiveTrackColor: AppColors.borderGray,
        thumbColor: AppColors.primaryColorDark,
        overlayColor: AppColors.primaryColorDark,
      ),

      // 디바이더 테마
      dividerTheme: DividerThemeData(color: AppColors.borderGray, thickness: 1),
    );
  }
}
