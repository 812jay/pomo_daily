import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';

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
      color: AppColors.primaryColor,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppTitle(), SizedBox(height: 20), LoadingIndicator()],
        ),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Pomo Daily',
      style: TextStyle(fontSize: 30, color: Colors.white),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(color: Colors.white);
  }
}
