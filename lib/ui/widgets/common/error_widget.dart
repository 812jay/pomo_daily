import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/ui/widgets/common/lottie_icon.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.exception});

  final Object exception;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LottieIcon('dinosaur', animate: true),
          const SizedBox(height: 20),
          const Text(
            'Oops! Something went wrong',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Please try again later',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
