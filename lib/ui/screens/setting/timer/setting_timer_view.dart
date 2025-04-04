import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/providers/timer_provider.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/ui/widgets/common/custom_slider.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_item.dart';
import 'package:pomo_daily/utils/duration_extensions.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';

class SettingTimerView extends StatelessWidget {
  const SettingTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TimerSettingHeader(),
              SizedBox(height: 20),
              TimerSettingContainer(),
              SizedBox(height: 20),
              SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerSettingHeader extends StatelessWidget {
  const TimerSettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        SvgIcon(
          onTap: () => Navigator.pop(context),
          iconName: 'chevron-left',
          iconColor: context.colors.iconPrimary,
          size: 42,
        ),
        Text(
          l10n.timerSettings,
          style: AppTextStyles.headline3.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class TimerSettingContainer extends StatelessWidget {
  const TimerSettingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final labelWidth = MediaQuery.of(context).size.width * 0.2;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.border, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FocusTimeSlider(labelWidth: labelWidth),
          BreakTimeSlider(labelWidth: labelWidth),
          SetsSlider(labelWidth: labelWidth),
          AutoPlaySwitch(labelWidth: labelWidth),
        ],
      ),
    );
  }
}

class FocusTimeSlider extends ConsumerWidget {
  final double labelWidth;

  const FocusTimeSlider({required this.labelWidth, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerController = ref.read(timerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.focusTime,
      labelWidth: labelWidth,
      suffixWidget: Expanded(
        child: CustomSlider(
          value: timerController.workDuration.toDoubleMinutes,
          labelSuffix: 'min',
          onChanged: timerController.setWorkDuration,
        ),
      ),
    );
  }
}

class BreakTimeSlider extends ConsumerWidget {
  final double labelWidth;

  const BreakTimeSlider({required this.labelWidth, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerController = ref.read(timerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.breakTime,
      labelWidth: labelWidth,
      suffixWidget: Expanded(
        child: CustomSlider(
          value: timerController.breakDuration.toDoubleMinutes,
          labelSuffix: 'min',
          onChanged: timerController.setBreakDuration,
        ),
      ),
    );
  }
}

class SetsSlider extends ConsumerWidget {
  final double labelWidth;

  const SetsSlider({required this.labelWidth, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerController = ref.read(timerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.sets,
      labelWidth: labelWidth,
      suffixWidget: Expanded(
        child: CustomSlider(
          value: timerController.totalSets.toDouble(),
          min: 1,
          max: 12,
          division: 11,
          onChanged: (value) {
            ref.read(timerProvider.notifier).setTotalSets(value);
          },
        ),
      ),
    );
  }
}

class AutoPlaySwitch extends ConsumerWidget {
  final double labelWidth;

  const AutoPlaySwitch({required this.labelWidth, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerController = ref.read(timerProvider.notifier);
    final autoPlay = ref.watch(timerProvider).value?.autoPlay ?? false;
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.autoPlay,
      labelWidth: labelWidth,
      isExpandedLabel: true,
      suffixWidget: CupertinoSwitch(
        value: autoPlay,
        onChanged: timerController.setAutoPlay,
      ),
    );
  }
}

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final timerController = ref.read(timerProvider.notifier);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerRight,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(context.colors.background),
          shadowColor: WidgetStateProperty.all(context.colors.border),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: context.colors.border),
            ),
          ),
        ),
        onPressed: () {
          timerController.saveSettings();
          Navigator.pop(context);
        },
        child: Text(
          l10n.save,
          style: AppTextStyles.body1.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
