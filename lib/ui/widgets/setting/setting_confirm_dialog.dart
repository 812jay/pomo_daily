import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';

class SettingConfirmDialog extends StatelessWidget {
  const SettingConfirmDialog({super.key});

  static Future<bool?> show({required BuildContext context}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: context.colors.dialogBarrier,
      builder: (context) => const SettingConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.dialogBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: context.colors.border),
      ),
      title: _DialogTitle(),
      content: _DialogContent(),
      actions: const [_CancelButton(), _SaveButton()],
    );
  }
}

class _DialogTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.timerSettingSaveTitle,
      style: AppTextStyles.headline2.copyWith(
        color: context.colors.textPrimary,
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.timerSettingSaveContent,
      style: AppTextStyles.body1.copyWith(color: context.colors.textPrimary),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextButton(
      onPressed: () => Navigator.pop(context, false),
      child: Text(
        l10n.cancel,
        style: AppTextStyles.body1.copyWith(color: context.colors.textPrimary),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text(
        l10n.saveConfirm,
        style: AppTextStyles.body1.copyWith(color: context.colors.textPrimary),
      ),
    );
  }
}
