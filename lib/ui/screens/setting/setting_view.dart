import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/providers/theme_provider.dart';
import 'package:pomo_daily/providers/vibration_provider.dart';
import 'package:pomo_daily/ui/widgets/setting/setting_item.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';
import 'package:pomo_daily/providers/locale_provider.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SettingHeader(),
                SizedBox(height: 20),
                const SettingContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingHeader extends StatelessWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.settings,
      style: AppTextStyles.headline3.copyWith(
        color: context.colors.textPrimary,
      ),
    );
  }
}

class SettingContainer extends StatelessWidget {
  const SettingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGray, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimerSettingItem(),
          VibrationSettingItem(),
          LanguageSettingItem(),
          ThemeSettingItem(),
        ],
      ),
    );
  }
}

class TimerSettingItem extends StatelessWidget {
  const TimerSettingItem({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.timerSettings,
      onTap: () => Navigator.pushNamed(context, '/setting/timer'),
    );
  }
}

class ThemeSettingItem extends ConsumerWidget {
  const ThemeSettingItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeController = ref.read(themeProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.darkMode,
      isExpandedLabel: true,
      suffixWidget: themeState.when(
        data:
            (isDarkMode) => CupertinoSwitch(
              value: isDarkMode == ThemeMode.dark,
              onChanged: (value) => themeController.toggleTheme(isDarkMode),
            ),
        loading:
            () => const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        error: (error, stack) => const Icon(Icons.error_outline),
      ),
    );
  }
}

class LanguageSettingItem extends ConsumerWidget {
  const LanguageSettingItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.language,
      isExpandedLabel: true,
      suffixWidget: locale.when(
        data:
            (currentLocale) => DropdownButton<String>(
              value: currentLocale.languageCode,
              underline: Container(),
              items: [
                DropdownMenuItem(value: 'ko', child: Text(l10n.korean)),
                DropdownMenuItem(value: 'en', child: Text(l10n.english)),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  ref.read(localeProvider.notifier).setLocale(value);
                }
              },
            ),
        loading:
            () => const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        error:
            (error, _) =>
                Icon(Icons.error_outline, color: AppColors.error, size: 18),
      ),
    );
  }
}

class VibrationSettingItem extends ConsumerWidget {
  const VibrationSettingItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vibrationState = ref.watch(vibrationProvider);
    final vibrationController = ref.read(vibrationProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SettingItem(
      label: l10n.vibration,
      isExpandedLabel: true,
      suffixWidget: vibrationState.when(
        data:
            (isVibration) => CupertinoSwitch(
              value: isVibration,
              onChanged:
                  (value) => vibrationController.toggleVibration(isVibration),
            ),
        loading:
            () => const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        error:
            (error, stack) => Icon(
              Icons.error_outline,
              color: context.colors.error,
              size: 18,
            ),
      ),
    );
  }
}
