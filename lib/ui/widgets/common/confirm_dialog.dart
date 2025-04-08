import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/generated/l10n/app_localizations.dart';
import 'package:pomo_daily/ui/widgets/common/action_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool showCancelButton;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText,
    this.confirmText,
    this.onCancel,
    this.onConfirm,
    this.showCancelButton = true,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool showCancelButton = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: context.colors.dialogBarrier,
      builder:
          (context) => ConfirmDialog(
            title: title,
            content: content,
            cancelText: cancelText,
            confirmText: confirmText,
            onCancel: onCancel,
            onConfirm: onConfirm,
            showCancelButton: showCancelButton,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: context.colors.dialogBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: context.colors.border),
      ),
      title: Text(
        title,
        style: AppTextStyles.headline2.copyWith(
          color: context.colors.textPrimary,
        ),
      ),
      content: Text(
        content,
        style: AppTextStyles.body1.copyWith(color: context.colors.textPrimary),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showCancelButton) ...[
              ActionButton(
                label: cancelText ?? l10n.cancel,
                onPressed: onCancel ?? () => Navigator.pop(context, false),
                margin: EdgeInsets.zero,
                textStyle: AppTextStyles.body2,
              ),
              const SizedBox(width: 8),
            ],
            ActionButton(
              label: confirmText ?? l10n.saveConfirm,
              onPressed: onConfirm ?? () => Navigator.pop(context, true),
              margin: EdgeInsets.zero,
              textStyle: AppTextStyles.body2,
            ),
          ],
        ),
      ],
    );
  }
}
