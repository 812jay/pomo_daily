import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/res/timer_config_model.dart';
import 'package:pomo_daily/providers/timer_provider.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/ui/widgets/common/custom_slider.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_confirm_dialog.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_item.dart';
import 'package:pomo_daily/utils/duration_extensions.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';
import 'package:pomo_daily/utils/logger.dart';

class TimerSettingView extends ConsumerStatefulWidget {
  const TimerSettingView({super.key});

  @override
  ConsumerState<TimerSettingView> createState() => _TimerSettingViewState();
}

class _TimerSettingViewState extends ConsumerState<TimerSettingView> {
  late TimerConfigModel _settings;

  @override
  void initState() {
    super.initState();
    _loadCurrentSettings();
  }

  void _loadCurrentSettings() {
    final timer = ref.read(timerProvider.notifier);
    _settings = TimerConfigModel(
      workDuration: timer.workDuration.toDoubleMinutes,
      breakDuration: timer.breakDuration.toDoubleMinutes,
      setCount: timer.totalSets.toDouble(),
      autoPlay: timer.autoPlay,
    );
  }

  void _updateSettings(TimerConfigModel settings) {
    setState(() => _settings = settings);
  }

  Future<void> _saveSettings() async {
    if (!await _confirmSaveIfNeeded() || !mounted) return;
    _applySettings();
    if (mounted) Navigator.pop(context);
  }

  void _applySettings() {
    final timer = ref.read(timerProvider.notifier);
    timer
      ..setWorkDuration(_settings.workDuration)
      ..setBreakDuration(_settings.breakDuration)
      ..setTotalSets(_settings.setCount)
      ..setAutoPlay(_settings.autoPlay)
      ..saveSettings();
  }

  Future<bool> _confirmSaveIfNeeded() async {
    final timerStatus = ref.read(timerProvider).value?.status;

    // 타이머가 initial 상태가 아닐 때만 확인 다이얼로그 표시
    if (timerStatus != null && timerStatus != TimerStatus.initial) {
      final confirmed = await SettingConfirmDialog.show(context: context);
      return confirmed ?? false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: 20),
              _SettingsForm(
                settings: _settings,
                onSettingsChanged: _updateSettings,
              ),
              const SizedBox(height: 20),
              _SaveButton(onSave: _saveSettings),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsForm extends StatelessWidget {
  final TimerConfigModel settings;
  final ValueChanged<TimerConfigModel> onSettingsChanged;

  const _SettingsForm({
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsContainer(
      child: _SettingsContent(
        settings: settings,
        onSettingsChanged: onSettingsChanged,
      ),
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  final Widget child;

  const _SettingsContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class _SettingsContent extends StatelessWidget {
  final TimerConfigModel settings;
  final ValueChanged<TimerConfigModel> onSettingsChanged;

  const _SettingsContent({
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidth = MediaQuery.of(context).size.width * 0.2;

    return Column(
      children: [
        _FocusTimeSlider(
          labelWidth: labelWidth,
          value: settings.workDuration,
          onChanged:
              (value) =>
                  onSettingsChanged(settings.copyWith(workDuration: value)),
        ),
        _BreakTimeSlider(
          labelWidth: labelWidth,
          value: settings.breakDuration,
          onChanged:
              (value) =>
                  onSettingsChanged(settings.copyWith(breakDuration: value)),
        ),
        _SetsSlider(
          labelWidth: labelWidth,
          value: settings.setCount,
          onChanged:
              (value) => onSettingsChanged(settings.copyWith(setCount: value)),
        ),
        _AutoPlaySwitch(
          labelWidth: labelWidth,
          value: settings.autoPlay,
          onChanged:
              (value) => onSettingsChanged(settings.copyWith(autoPlay: value)),
        ),
      ],
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

  const _SaveButton({required this.onSave});

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
