import 'package:flutter/material.dart';
import 'package:pomo_daily/services/base_storage_service.dart';

class LocaleService extends BaseStorageService {
  static const String _localeKey = 'locale';

  Future<void> initializeLocaleSetting() async {
    final box = await openBox();
    if (!box.containsKey(_localeKey)) {
      await setValue(_localeKey, 'en');
    }
  }

  Future<void> setLocale(String languageCode) async {
    await setValue(_localeKey, languageCode);
  }

  Future<String> getLocale() async {
    return await getValue(_localeKey, 'en');
  }

  Locale getLocaleFromLanguageCode(String languageCode) {
    return Locale(languageCode);
  }
}
