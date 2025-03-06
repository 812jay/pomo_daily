import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/enum/timer/timer_type.dart';
import 'package:pomo_daily/theme/app_colors.dart';
import 'package:pomo_daily/theme/app_text_styles.dart';
import 'package:pomo_daily/ui/widget/common/circle_button.dart';

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
            // 모드 표기
            Text(timerState.mode.comment, style: AppTextStyles.headline1,), 

            // 세트 진행 상황 표시
            Text(
              '${timerState.completedSets}/${timerState.totalSets} 세트',
              style: AppTextStyles.body1,
            ),
            const SizedBox(height: 10),

            // 현재 세트 표시x

            // 타이머 표시
            Text(
              ref.read(timerProvider.notifier).formatTime(timerState.duration),
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // 컨트롤 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 시작/일시정지 버튼
                CircleButton(
                  onPressed: () {
                    if (timerState.status == TimerStatus.running) {
                      ref.read(timerProvider.notifier).pause();
                    } else {
                      ref.read(timerProvider.notifier).start();
                    }
                  },
                  icon: Icon(
                    timerState.status == TimerStatus.running
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                // const SizedBox(width: 20),
                // CircleButton(
                //   onPressed: () => ref.read(timerProvider.notifier).reset(),
                //   icon: Icon(Icons.refresh),
                // ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
