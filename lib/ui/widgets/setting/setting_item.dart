import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_text_styles.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.label,
    this.isExpandedLabel = false,
    this.labelWidth,
    this.suffixWidget,
    this.onTap,
  });
  final String label;
  final bool isExpandedLabel;
  final double? labelWidth;
  final Widget? suffixWidget;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            isExpandedLabel
                ? Expanded(child: Text(label, style: AppTextStyles.body1))
                : SizedBox(
                  width: labelWidth,
                  child: Text(label, style: AppTextStyles.body1),
                ),
            suffixWidget ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
