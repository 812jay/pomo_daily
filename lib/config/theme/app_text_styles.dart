import 'package:flutter/material.dart';

import 'app_colors.dart';

class Fonts {
  static const String spoqa = 'Spoqa Han Sans Neo';
}

// 폰트 크기 정의
class FontSizes {
  // Display
  static const double display1 = 57;
  static const double display2 = 45;
  static const double display3 = 36;

  // Headline
  static const double headline1 = 32;
  static const double headline2 = 28;
  static const double headline3 = 24;

  // Body
  static const double body1 = 16;
  static const double body2 = 14;

  // Caption
  static const double caption1 = 12;
  static const double caption2 = 11;
}

class AppTextStyles {
  // Headline 스타일
  static const headline1 = TextStyle(
    fontSize: FontSizes.headline1,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: Fonts.spoqa,
  );

  static const headline2 = TextStyle(
    fontSize: FontSizes.headline2,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: Fonts.spoqa,
  );

  static const headline3 = TextStyle(
    fontSize: FontSizes.headline3,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: Fonts.spoqa,
  );

  // Body 스타일
  static const body1 = TextStyle(
    fontSize: FontSizes.body1,
    color: AppColors.textPrimary,
    fontFamily: Fonts.spoqa,
    height: 1.5,
  );

  static const body2 = TextStyle(
    fontSize: FontSizes.body2,
    color: AppColors.textPrimary,
    fontFamily: Fonts.spoqa,
    height: 1.4,
  );

  // Caption 스타일
  static const caption1 = TextStyle(
    fontSize: FontSizes.caption1,
    color: AppColors.textSecondary,
    fontFamily: Fonts.spoqa,
    letterSpacing: 0.2,
  );

  static const caption2 = TextStyle(
    fontSize: FontSizes.caption2,
    color: AppColors.textSecondary,
    fontFamily: Fonts.spoqa,
    letterSpacing: 0.1,
  );
}
