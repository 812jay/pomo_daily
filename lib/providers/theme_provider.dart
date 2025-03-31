import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/services/theme_service.dart';
import 'package:pomo_daily/utils/logger.dart';

final themeServiceProvider = Provider((ref) => ThemeService());

// ThemeMode를 위한 별도의 provider 추가
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class ThemeState extends AsyncNotifier<bool> {
  late ThemeService _themeService;

  @override
  Future<bool> build() async {
    _themeService = ref.read(themeServiceProvider);
    final isDarkMode = await _themeService.getTheme();
    // 초기 themeMode 설정
    ref.read(themeModeProvider.notifier).state =
        isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return isDarkMode;
  }

  Future<void> initializeThemeSetting() async {
    _themeService = ref.read(themeServiceProvider);
    final isDarkMode = await _themeService.getTheme();
    state = AsyncData(isDarkMode);
  }

  Future<void> toggleTheme(bool currentValue) async {
    state = const AsyncLoading();

    try {
      final newValue = !currentValue;
      await _themeService.setTheme(newValue);
      final savedValue = await _themeService.getTheme();

      // themeMode 업데이트
      ref.read(themeModeProvider.notifier).state =
          savedValue ? ThemeMode.dark : ThemeMode.light;

      state = AsyncData(savedValue);
      AppLogger.debug('테마 설정이 변경되었습니다. 새 값: $savedValue', tag: 'ThemeState');
    } catch (e, stack) {
      state = AsyncError(e, stack);
      AppLogger.error('테마 설정 변경 중 오류 발생', tag: 'ThemeState');
    }
  }

  Future<void> setTheme(bool isDarkMode) async {
    await _themeService.setTheme(isDarkMode);
    final savedValue = await _themeService.getTheme();
    state = AsyncData(savedValue);
  }

  Future<bool> getTheme() async {
    final savedValue = await _themeService.getTheme();
    state = AsyncData(savedValue);
    return savedValue;
  }
}

final themeProvider = AsyncNotifierProvider<ThemeState, bool>(
  () => ThemeState(),
);
