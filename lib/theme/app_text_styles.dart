import 'package:flutter/material.dart';

import 'app_colors.dart';

class Fonts {
  static String spoqa = 'Spoqa Han Sans Neo';
}

class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const body1 = TextStyle(fontSize: 16, color: AppColors.textPrimary);

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}
