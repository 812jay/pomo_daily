import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/enum/timer/timer_type.dart';
import 'package:pomo_daily/theme/app_colors.dart';
import 'package:pomo_daily/ui/widget/common/circle_button.dart';
import 'package:pomo_daily/ui/widget/common/lottie_icon.dart';
import 'package:pomo_daily/ui/widget/common/svg_icon.dart';

import 'timer_view_model.dart';

class TimerView extends ConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            LottieIcon(
              timerState.mode.isWork ? 'rocket' : 'relax',
              animate: timerState.status.isRunning,
            ),
            // 타이머 표시
            Text(
              ref.read(timerProvider.notifier).formatTime(timerState.duration),
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: timerState.totalSets,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final bool isCompleted = timerState.completedSets > index;
                  return Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          isCompleted
                              ? AppColors.success
                              : AppColors.borderGray,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // Text('${timerState.status}'),

            // 컨트롤 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                // 시작/일시정지 버튼
                if (!timerState.status.isFinished)
                  CircleButton(
                    backgroundColor: AppColors.whiteColor,
                    outlined: true,
                    onPressed: () {
                      if (timerState.status == TimerStatus.running) {
                        ref.read(timerProvider.notifier).pause();
                      } else {
                        ref.read(timerProvider.notifier).start();
                      }
                    },
                    child: SvgIcon(
                      iconName: timerState.status.isRunning ? 'pause' : 'play',
                      iconColor: AppColors.iconPrimary,
                    ),
                  ),
                if (timerState.status.isFinished)
                  CircleButton(
                    outlined: true,
                    onPressed: () => ref.read(timerProvider.notifier).reset(),
                    child: SvgIcon(
                      iconName: 'refresh',
                      iconColor: AppColors.iconPrimary,
                    ),
                  ),
                if (timerState.status.isPaused)
                  CircleButton(
                    outlined: true,
                    onPressed:
                        () => ref.read(timerProvider.notifier).skipToNextSet(),
                    child: SvgIcon(
                      iconName: 'skip',
                      iconColor: AppColors.iconPrimary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
