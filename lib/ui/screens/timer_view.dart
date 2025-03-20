import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/providers/timer_provider.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/ui/widgets/common/circle_button.dart';
import 'package:pomo_daily/ui/widgets/common/lottie_icon.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';

class TimerView extends ConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: timerState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data:
            (timer) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 200),
                    LottieIcon(
                      timer.mode.isWork ? 'rocket' : 'relax',
                      animate: timer.status.isRunning,
                    ),
                    // 타이머 표시
                    Text(
                      ref
                          .read(timerProvider.notifier)
                          .formatTime(timer.duration),
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: timer.totalSets,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder:
                            (context, index) => SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final bool isCompleted = timer.completedSets > index;
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

                    // 컨트롤 버튼
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 시작/일시정지 버튼
                        if (!timer.status.isFinished)
                          CircleButton(
                            backgroundColor: AppColors.whiteColor,
                            outlined: true,
                            onPressed: () {
                              if (timer.status == TimerStatus.running) {
                                ref.read(timerProvider.notifier).pause();
                              } else {
                                ref.read(timerProvider.notifier).start();
                              }
                            },
                            child: SvgIcon(
                              iconName:
                                  timer.status.isRunning ? 'pause' : 'play',
                              iconColor: AppColors.iconPrimary,
                            ),
                          ),
                        if (timer.status.isFinished)
                          CircleButton(
                            outlined: true,
                            onPressed:
                                () => ref.read(timerProvider.notifier).reset(),
                            child: SvgIcon(
                              iconName: 'refresh',
                              iconColor: AppColors.iconPrimary,
                            ),
                          ),
                        if (timer.status.isPaused)
                          CircleButton(
                            outlined: true,
                            onPressed:
                                () =>
                                    ref
                                        .read(timerProvider.notifier)
                                        .skipToNextSet(),
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
            ),
      ),
    );
  }
}
