import 'package:flutter/material.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';
import 'package:pomo_daily/ui/widgets/common/confirm_dialog.dart';

class TimerResetConfirmDialog {
  static Future<bool?> show({required BuildContext context}) {
    final l10n = AppLocalizations.of(context)!;

    return ConfirmDialog.show(
      context: context,
      title: l10n.timerResetTitle,
      content: l10n.timerResetContent,
      cancelText: l10n.cancel,
      confirmText: l10n.confirm,
    );
  }
}
