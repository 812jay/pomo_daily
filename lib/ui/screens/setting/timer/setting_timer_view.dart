import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/providers/timer_provider.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/ui/widgets/common/custom_slider.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_item.dart';
import 'package:pomo_daily/utils/duration_extensions.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';

class SettingTimerView extends ConsumerWidget {
  const SettingTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerController = ref.read(timerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final labelWidth = MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgIcon(
                  onTap: () => Navigator.pop(context),
                  iconName: 'chevron-left',
                  size: 42,
                ),
                Text(l10n.timerSettings, style: AppTextStyles.headline3),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGray, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingItem(
                    label: l10n.focusTime,
                    labelWidth: labelWidth,
                    suffixWidget: Expanded(
                      child: CustomSlider(
                        value: timerController.workDuration.toDoubleMinutes,
                        labelSuffix: 'min',
                        onChanged: timerController.setWorkDuration,
                      ),
                    ),
                  ),
                  SettingItem(
                    label: l10n.breakTime,
                    labelWidth: labelWidth,
                    suffixWidget: Expanded(
                      child: CustomSlider(
                        value: timerController.breakDuration.toDoubleMinutes,
                        labelSuffix: 'min',
                        onChanged: timerController.setBreakDuration,
                      ),
                    ),
                  ),
                  SettingItem(
                    label: l10n.sets,
                    labelWidth: labelWidth,
                    suffixWidget: Expanded(
                      child: CustomSlider(
                        value: timerController.totalSets.toDouble(),
                        min: 1,
                        max: 20,
                        division: 19,
                        onChanged: (value) {
                          ref.read(timerProvider.notifier).setTotalSets(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.backgroundColor,
                  ),
                  shadowColor: WidgetStateProperty.all(AppColors.borderBlack),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors.borderGray),
                    ),
                  ),
                ),
                onPressed: () {
                  ref.read(timerProvider.notifier).saveSettings();
                  Navigator.pop(context);
                },
                child: Text(l10n.save, style: AppTextStyles.body1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
