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

    splashState.when(
      data: (isLoaded) {
        if (isLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/home'); // 홈으로 이동
          });
        }
        return SizedBox.shrink();
      },
      loading: () => _buildSplashScreen(), // 로딩 중 화면
      error: (err, stack) => Center(child: Text('Error: $err')),
    );

    return Scaffold(body: _buildSplashScreen());
  }

  /// Splash 화면 UI
  Widget _buildSplashScreen() {
    return Container(
      color: AppColors.primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pomo Daily',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
