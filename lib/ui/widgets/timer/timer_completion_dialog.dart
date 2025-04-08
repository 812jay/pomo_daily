import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';

class TimerCompletionDialog extends StatelessWidget {
  const TimerCompletionDialog({
    super.key,
    required this.workDuration,
    required this.breakDuration,
    required this.totalSets,
  });

  static Future<void> show({
    required BuildContext context,
    required int workDuration,
    required int breakDuration,
    required int totalSets,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => TimerCompletionDialog(
            workDuration: workDuration,
            breakDuration: breakDuration,
            totalSets: totalSets,
          ),
    );
  }

  final int workDuration;
  final int breakDuration;
  final int totalSets;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(16),
      content: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _DialogContent(
            workDuration: workDuration,
            breakDuration: breakDuration,
            totalSets: totalSets,
          ),
          const _CongratulationsAnimation(),
        ],
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.workDuration,
    required this.breakDuration,
    required this.totalSets,
  });

  final int workDuration;
  final int breakDuration;
  final int totalSets;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/dancing_dog.json',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
            repeat: true,
          ),
          const _DialogTitle(),
          const SizedBox(height: 16),
          _TimerStats(
            workDuration: workDuration,
            breakDuration: breakDuration,
            totalSets: totalSets,
          ),
        ],
      ),
    );
  }
}

class _DialogTitle extends StatelessWidget {
  const _DialogTitle();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Text(l10n.completionTitle, style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        Text(l10n.completionSubtitle, style: AppTextStyles.body1),
      ],
    );
  }
}

class _TimerStats extends StatelessWidget {
  const _TimerStats({
    required this.workDuration,
    required this.breakDuration,
    required this.totalSets,
  });

  final int workDuration;
  final int breakDuration;
  final int totalSets;

  int get _totalFocusTime => workDuration * totalSets;
  int get _totalBreakTime {
    // 1세트이거나 마지막 세트 후에는 휴식시간이 없음
    if (totalSets <= 1) return 0;
    // 휴식 시간은 (전체 세트 수 - 1)만큼 있음
    return breakDuration * (totalSets - 1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalFocusTime = _totalFocusTime ~/ 60;
    final totalBreakTime = _totalBreakTime ~/ 60;
    return Column(
      children: [
        Text(
          '${l10n.totalFocusTime}: $totalFocusTime${l10n.minuteUnit}',
          style: AppTextStyles.body1,
        ),
        if (_totalBreakTime > 0) // 휴식 시간이 있을 때만 표시
          Text(
            '${l10n.totalBreakTime}: $totalBreakTime${l10n.minuteUnit}',
            style: AppTextStyles.body1,
          ),
        Text(
          '${l10n.totalSets}: $totalSets${l10n.setUnit}',
          style: AppTextStyles.body1,
        ),
      ],
    );
  }
}

class _CongratulationsAnimation extends StatelessWidget {
  const _CongratulationsAnimation();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -80,
      child: Lottie.asset(
        'assets/lotties/congratulations.json',
        width: 400,
        height: 400,
        fit: BoxFit.contain,
        repeat: true,
      ),
    );
  }
}
