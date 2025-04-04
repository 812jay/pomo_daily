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

class TimerSettingView extends ConsumerStatefulWidget {
  const TimerSettingView({super.key});

  @override
  ConsumerState<TimerSettingView> createState() => _TimerSettingsScreenState();
}

class _TimerSettingsScreenState extends ConsumerState<TimerSettingView> {
  late TimerSettings _settings;

  @override
  void initState() {
    super.initState();
    final timer = ref.read(timerProvider.notifier);
    _settings = TimerSettings(
      focusMinutes: timer.workDuration.toDoubleMinutes,
      breakMinutes: timer.breakDuration.toDoubleMinutes,
      sets: timer.totalSets.toDouble(),
      autoPlay: timer.autoPlay,
    );
  }

  void _saveSettings() {
    final timer = ref.read(timerProvider.notifier);
    timer
      ..setWorkDuration(_settings.focusMinutes)
      ..setBreakDuration(_settings.breakMinutes)
      ..setTotalSets(_settings.sets)
      ..setAutoPlay(_settings.autoPlay)
      ..saveSettings();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 20),
            _SettingsContainer(
              settings: _settings,
              onSettingsChanged:
                  (settings) => setState(() => _settings = settings),
            ),
            const SizedBox(height: 20),
            _SaveButton(onSave: _saveSettings),
          ],
        ),
      ),
    );
  }
}

class TimerSettings {
  final double focusMinutes;
  final double breakMinutes;
  final double sets;
  final bool autoPlay;

  const TimerSettings({
    required this.focusMinutes,
    required this.breakMinutes,
    required this.sets,
    required this.autoPlay,
  });

  TimerSettings copyWith({
    double? focusMinutes,
    double? breakMinutes,
    double? sets,
    bool? autoPlay,
  }) {
    return TimerSettings(
      focusMinutes: focusMinutes ?? this.focusMinutes,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      sets: sets ?? this.sets,
      autoPlay: autoPlay ?? this.autoPlay,
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  final TimerSettings settings;
  final ValueChanged<TimerSettings> onSettingsChanged;

  const _SettingsContainer({
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidth = MediaQuery.of(context).size.width * 0.2;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _FocusTimeSlider(
            labelWidth: labelWidth,
            value: settings.focusMinutes,
            onChanged:
                (value) =>
                    onSettingsChanged(settings.copyWith(focusMinutes: value)),
          ),
          _BreakTimeSlider(
            labelWidth: labelWidth,
            value: settings.breakMinutes,
            onChanged:
                (value) =>
                    onSettingsChanged(settings.copyWith(breakMinutes: value)),
          ),
          _SetsSlider(
            labelWidth: labelWidth,
            value: settings.sets,
            onChanged:
                (value) => onSettingsChanged(settings.copyWith(sets: value)),
          ),
          _AutoPlaySwitch(
            labelWidth: labelWidth,
            value: settings.autoPlay,
            onChanged:
                (value) =>
                    onSettingsChanged(settings.copyWith(autoPlay: value)),
          ),
        ],
      ),
    );
  }
}

class _FocusTimeSlider extends StatelessWidget {
  final double labelWidth;
  final double value;
  final ValueChanged<double> onChanged;

  const _FocusTimeSlider({
    required this.labelWidth,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      label: AppLocalizations.of(context)!.focusTime,
      labelWidth: labelWidth,
      suffixWidget: Expanded(
        child: CustomSlider(
          value: value,
          labelSuffix: 'min',
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _BreakTimeSlider extends StatelessWidget {
  final double labelWidth;
  final double value;
  final ValueChanged<double> onChanged;

  const _BreakTimeSlider({
    required this.labelWidth,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      label: AppLocalizations.of(context)!.breakTime,
      labelWidth: labelWidth,
      suffixWidget: Expanded(
        child: CustomSlider(
          value: value,
          labelSuffix: 'min',
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _SetsSlider extends StatelessWidget {
  final double labelWidth;
  final double value;
  final ValueChanged<double> onChanged;

  const _SetsSlider({
    required this.labelWidth,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      label: AppLocalizations.of(context)!.sets,
      labelWidth: labelWidth,
      suffixWidget: Expanded(
        child: CustomSlider(
          value: value,
          min: 1,
          max: 12,
          division: 11,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _AutoPlaySwitch extends StatelessWidget {
  final double labelWidth;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AutoPlaySwitch({
    required this.labelWidth,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      label: AppLocalizations.of(context)!.autoPlay,
      labelWidth: labelWidth,
      isExpandedLabel: true,
      suffixWidget: CupertinoSwitch(value: value, onChanged: onChanged),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onSave;

  const _SaveButton({required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
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
        onPressed: onSave,
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

class _Header extends StatelessWidget {
  const _Header();

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
