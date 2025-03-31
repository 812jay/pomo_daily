import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomo_daily/providers/locale_provider.dart';
import 'package:pomo_daily/providers/theme_provider.dart';
import 'package:pomo_daily/services/theme_service.dart';
import 'package:pomo_daily/services/vibration_service.dart';
import 'package:pomo_daily/ui/screens/home_view.dart';
import 'package:pomo_daily/ui/screens/setting/timer/setting_timer_view.dart';
import 'package:pomo_daily/ui/screens/splash_view.dart';
import 'package:pomo_daily/config/theme/app_theme.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // 설정 서비스 초기화
  final settingService = VibrationService();
  final themeService = ThemeService();

  // 앱 최초 설치 시 진동 설정 초기화
  await settingService.initializeVibrationSetting();
  await themeService.initializeThemeSetting();

  // 저장된 테마 값 가져오기
  final savedTheme = await themeService.getTheme();

  runApp(
    ProviderScope(
      overrides: [
        // 초기 테마 모드 설정
        themeModeProvider.overrideWith(
          (ref) => savedTheme ? ThemeMode.dark : ThemeMode.light,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    // 앱이 시작될 때 테마 상태 초기화
    ref.listen<AsyncValue<bool>>(themeProvider, (previous, next) {
      next.whenData((isDarkMode) {
        ref.read(themeModeProvider.notifier).state =
            isDarkMode ? ThemeMode.dark : ThemeMode.light;
      });
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale.value,
      home: SplashView(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashView());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeView());
          case '/setting/timer':
            return MaterialPageRoute(builder: (_) => const SettingTimerView());
        }
        return null;
      },
    );
  }
}
