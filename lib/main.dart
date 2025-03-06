import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/splash_view.dart';
import 'package:pomo_daily/theme/app_theme.dart';
import 'package:pomo_daily/ui/screen/timer/timer_view.dart';

void main() {
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
          case '/timer':
            return MaterialPageRoute(builder: (_) => const TimerView());
        }
        return null;
      },
    );
  }
}
