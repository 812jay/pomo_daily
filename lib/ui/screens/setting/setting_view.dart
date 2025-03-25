import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/providers/setting_provider.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_item.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingState = ref.watch(settingProvider);
    final settingController = ref.read(settingProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: AppTextStyles.headline3),
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
                    label: 'Timer Settings',
                    onTap: () {
                      Navigator.pushNamed(context, '/setting/timer');
                    },
                  ),
                  SettingItem(
                    label: 'Vibration',
                    isExpandedLabel: true,
                    suffixWidget: settingState.when(
                      data:
                          (isVibration) => CupertinoSwitch(
                            value: isVibration,
                            onChanged: (value) {
                              // 현재 값을 전달하여 토글
                              settingController.toggleVibration(isVibration);
                            },
                          ),
                      loading:
                          () => const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      error:
                          (error, stack) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                                size: 18,
                              ),
                            ],
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
