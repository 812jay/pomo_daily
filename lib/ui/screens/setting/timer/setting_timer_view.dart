import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/providers/timer_provider.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/ui/widgets/common/custom_slider.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_item.dart';

class SettingTimerView extends ConsumerWidget {
  const SettingTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
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
                Text('타이머 설정', style: AppTextStyles.headline3),
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
                    label: '집중시간',
                    labelWidth: 60,
                    suffixWidget: Expanded(
                      child: CustomSlider(
                        value: 5,
                        labelSuffix: '분',
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SettingItem(
                    label: '휴식시간',
                    labelWidth: 60,
                    suffixWidget: Expanded(
                      child: CustomSlider(
                        value: 5,
                        labelSuffix: '분',
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SettingItem(
                    label: '세트 수',
                    labelWidth: 60,
                    suffixWidget: Expanded(
                      child: CustomSlider(
                        value: 1,
                        min: 1,
                        max: 20,
                        division: 19,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
