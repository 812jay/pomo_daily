import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/services/locale_service.dart';
import 'package:pomo_daily/utils/logger.dart';

final localeServiceProvider = Provider((ref) => LocaleService());

class LocaleState extends AsyncNotifier<Locale> {
  late LocaleService _localeService;

  @override
  Future<Locale> build() async {
    _localeService = ref.read(localeServiceProvider);
    final languageCode = await _localeService.getLocale();
    return _localeService.getLocaleFromLanguageCode(languageCode);
  }

  Future<void> setLocale(String languageCode) async {
    state = const AsyncLoading();

    try {
      await _localeService.setLocale(languageCode);

      // 저장된 값 확인
      final savedLanguageCode = await _localeService.getLocale();
      final locale = _localeService.getLocaleFromLanguageCode(
        savedLanguageCode,
      );

      AppLogger.debug(
        '언어 설정이 변경되었습니다. 새 값: $savedLanguageCode',
        tag: 'LocaleState',
      );

      state = AsyncData(locale);
    } catch (e, stackTrace) {
      AppLogger.error(
        '언어 설정 변경 중 오류 발생',
        error: e,
        stackTrace: stackTrace,
        tag: 'LocaleState',
      );
      state = AsyncError(e, stackTrace);
    }
  }

  // 지원하는 언어 목록
  List<Map<String, String>> get supportedLanguages => [
    {'code': 'ko', 'name': '한국어'},
    {'code': 'en', 'name': 'English'},
  ];
}

final localeProvider = AsyncNotifierProvider<LocaleState, Locale>(
  () => LocaleState(),
);
