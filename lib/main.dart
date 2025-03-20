import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomo_daily/ui/screens/home_view.dart';
import 'package:pomo_daily/ui/screens/setting/timer/setting_timer_view.dart';
import 'package:pomo_daily/ui/screens/splash_view.dart';
import 'package:pomo_daily/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
