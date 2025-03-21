import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/data/models/timer/res/local/timer_local.dart';
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
    final timerController = ref.read(timerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: timerState.when(
        loading: () => const _LoadingView(),
        error: (error, stackTrace) => ErrorWidget(error),
        data:
            (timer) =>
                _TimerContent(timer: timer, timerController: timerController),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _TimerContent extends StatelessWidget {
  const _TimerContent({required this.timer, required this.timerController});

  final TimerLocal timer;
  final TimerState timerController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            _TimerAnimation(
              isWork: timer.mode.isWork,
              isRunning: timer.status.isRunning,
            ),
            _TimerDisplay(
              duration: timer.duration,
              timerController: timerController,
            ),
            _SetIndicator(
              totalSets: timer.totalSets,
              completedSets: timer.completedSets,
            ),
            const SizedBox(height: 30),
            _ControlButtons(timer: timer, timerController: timerController),
          ],
        ),
      ),
    );
  }
}

class _TimerAnimation extends StatelessWidget {
  const _TimerAnimation({required this.isWork, required this.isRunning});

  final bool isWork;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    return LottieIcon(isWork ? 'rocket' : 'relax', animate: isRunning);
  }
}

class _TimerDisplay extends StatelessWidget {
  const _TimerDisplay({required this.duration, required this.timerController});

  final int duration;
  final TimerState timerController;

  @override
  Widget build(BuildContext context) {
    return Text(
      timerController.formatTime(duration),
      style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
    );
  }
}

class _SetIndicator extends StatelessWidget {
  const _SetIndicator({required this.totalSets, required this.completedSets});

  final int totalSets;
  final int completedSets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: totalSets,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) => _SetDot(isCompleted: completedSets > index),
      ),
    );
  }
}

class _SetDot extends StatelessWidget {
  const _SetDot({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isCompleted ? AppColors.success : AppColors.borderGray,
      ),
    );
  }
}

class _ControlButtons extends StatelessWidget {
  const _ControlButtons({required this.timer, required this.timerController});

  final TimerLocal timer;
  final TimerState timerController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!timer.status.isFinished)
          _PlayPauseButton(
            isRunning: timer.status.isRunning,
            onPressed: () {
              if (timer.status == TimerStatus.running) {
                timerController.pause();
              } else {
                timerController.start();
              }
            },
          ),
        if (timer.status.isFinished)
          _ResetButton(onPressed: timerController.reset),
        if (timer.status.isPaused)
          _SkipButton(onPressed: timerController.skipToNextSet),
      ],
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.isRunning, required this.onPressed});

  final bool isRunning;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      backgroundColor: AppColors.whiteColor,
      outlined: true,
      onPressed: onPressed,
      child: SvgIcon(
        iconName: isRunning ? 'pause' : 'play',
        iconColor: AppColors.iconPrimary,
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      outlined: true,
      onPressed: onPressed,
      child: SvgIcon(iconName: 'refresh', iconColor: AppColors.iconPrimary),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      outlined: true,
      onPressed: onPressed,
      child: SvgIcon(iconName: 'skip', iconColor: AppColors.iconPrimary),
    );
  }
}
