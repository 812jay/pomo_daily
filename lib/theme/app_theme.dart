import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.light(primary: AppColors.primaryColor),

      // 텍스트 테마
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1,
        bodyLarge: AppTextStyles.body1,
        bodySmall: AppTextStyles.caption,
      ),

      // 앱바 테마
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        titleTextStyle: AppTextStyles.heading1.copyWith(
          color: Colors.white,
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
    return ThemeData.dark().copyWith(
      // 다크 테마에 대한 커스텀 설정
    );
  }
}
