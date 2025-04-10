import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/data/models/timer/res/timer_state_model.dart';
import 'package:pomo_daily/providers/timer_provider.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/ui/widgets/common/circle_button.dart';
import 'package:pomo_daily/ui/widgets/common/lottie_icon.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/ui/widgets/timer/timer_completion_dialog.dart';

class TimerView extends ConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);

    ref.listen<AsyncValue<TimerStateModel>>(timerProvider, (previous, next) {
      if (next.value?.status == TimerStatus.finished) {
        TimerCompletionDialog.show(
          context: context,
          workDuration: timerController.workDuration,
          breakDuration: timerController.breakDuration,
          totalSets: timerController.totalSets,
        );
      }
    });

    return Scaffold(
      backgroundColor: context.colors.background,
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

  final TimerStateModel timer;
  final TimerState timerController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
      width: MediaQuery.of(context).size.width * 0.5,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          totalSets,
          (index) => _SetDot(isCompleted: completedSets > index),
        ),
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
        color:
            isCompleted
                ? context.colors.completedDot
                : context.colors.uncompletedDot,
      ),
    );
  }
}

class _ControlButtons extends StatelessWidget {
  const _ControlButtons({required this.timer, required this.timerController});

  final TimerStateModel timer;
  final TimerState timerController;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
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
        if (timer.status.isFinished || timer.status.isPaused)
          _ResetButton(
            onPressed: () => timerController.resetWithConfirm(context),
          ),
        if (timer.status.isPaused)
          _SkipButton(
            onPressed: () => timerController.skipWithConfirm(context),
          ),
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
      backgroundColor: context.colors.background,
      outlined: true,
      onPressed: onPressed,
      child: SvgIcon(
        iconName: isRunning ? 'pause' : 'play',
        iconColor: context.colors.iconPrimary,
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
      backgroundColor: context.colors.background,
      child: SvgIcon(
        iconName: 'refresh',
        iconColor: context.colors.iconPrimary,
      ),
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
      backgroundColor: context.colors.background,
      child: SvgIcon(iconName: 'skip', iconColor: context.colors.iconPrimary),
    );
  }
}
