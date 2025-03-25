import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomo_daily/services/setting/setting_service.dart';
import 'package:pomo_daily/ui/screens/home_view.dart';
import 'package:pomo_daily/ui/screens/setting/timer/setting_timer_view.dart';
import 'package:pomo_daily/ui/screens/splash_view.dart';
import 'package:pomo_daily/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // 설정 서비스 초기화
  final settingService = SettingService();
  // 앱 최초 설치 시 진동 설정 초기화
  await settingService.initializeVibrationSetting();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
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
