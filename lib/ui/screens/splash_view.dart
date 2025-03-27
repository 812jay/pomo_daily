import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';

/// Splash 상태를 관리하는 Provider
final splashProvider = FutureProvider<bool>((ref) async {
  await Future.delayed(Duration(seconds: 3)); // 3초 대기 (API 호출 가능)
  return true; // 로딩 완료
});

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashState = ref.watch(splashProvider);

    return Scaffold(
      body: splashState.when(
        data: (isLoaded) => SplashRedirect(isLoaded: isLoaded),
        loading: () => const SplashContent(),
        error: (err, stack) => ErrorWidget(err),
      ),
    );
  }
}

class SplashRedirect extends StatelessWidget {
  const SplashRedirect({super.key, required this.isLoaded});

  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
    return const SizedBox.shrink();
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppTitle(),
            const SizedBox(height: 20),
            const AppLogo(),
          ],
        ),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Pomo Daily', style: AppTextStyles.headline1);
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logos/png/ic_launcher_play_store_removebg.png',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
