import 'package:pomo_daily/services/base_storage_service.dart';

class ThemeService extends BaseStorageService {
  static const String _themeKey = 'theme';

  Future<void> initializeThemeSetting() async {
    final box = await openBox();
    if (!box.containsKey(_themeKey)) {
      await setValue(_themeKey, false);
    }
  }

  Future<void> setTheme(bool isDarkMode) async {
    await setValue(_themeKey, isDarkMode);
  }

  Future<bool> getTheme() async {
    return await getValue(_themeKey, false);
  }
}
