import 'package:flutter/material.dart';
import 'package:pomo_daily/services/base_storage_service.dart';

class ThemeService extends BaseStorageService {
  static const String _themeKey = 'theme';

  Future<void> initializeThemeSetting() async {
    final box = await openBox();
    if (!box.containsKey(_themeKey)) {
      await setValue(_themeKey, ThemeMode.light);
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await setValue(_themeKey, themeMode);
  }

  Future<ThemeMode> getTheme() async {
    return await getValue(_themeKey, ThemeMode.light);
  }
}
