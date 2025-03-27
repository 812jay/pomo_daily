import 'package:flutter/material.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.value = 5,
    this.labelSuffix,
    this.min = 5,
    this.max = 60,
    this.division = 11,
    required this.onChanged,
  });
  final double value;
  final String? labelSuffix;
  final double min;
  final double max;
  final int division;

  final void Function(double) onChanged;

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  late double currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 12,
        activeTrackColor: AppColors.primaryColor,
        inactiveTrackColor: AppColors.borderGray,
        thumbColor: AppColors.whiteColor,
        valueIndicatorColor: AppColors.primaryColor,
        valueIndicatorTextStyle: TextStyle(color: AppColors.whiteColor),
        tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 0),
      ),
      child: Slider(
        value: currentValue,
        min: widget.min,
        max: widget.max,
        divisions: widget.division,
        label: '${currentValue.toInt()}${widget.labelSuffix ?? ''}',
        onChanged: (value) {
          setState(() {
            currentValue = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
