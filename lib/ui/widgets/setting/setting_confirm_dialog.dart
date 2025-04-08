import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';
import 'package:pomo_daily/ui/widgets/common/action_button.dart';

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
      actionsAlignment: MainAxisAlignment.end,
      actions: const [_DialogActions()],
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

class _DialogActions extends StatelessWidget {
  const _DialogActions();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 취소 버튼
        ActionButton(
          label: l10n.cancel,
          onPressed: () => Navigator.pop(context, false),
          margin: EdgeInsets.zero,
          textStyle: AppTextStyles.body2,
        ),
        const SizedBox(width: 8),
        // 저장 버튼
        ActionButton(
          label: l10n.saveConfirm,
          onPressed: () => Navigator.pop(context, true),
          margin: EdgeInsets.zero,
          textStyle: AppTextStyles.body2,
        ),
      ],
    );
  }
}
