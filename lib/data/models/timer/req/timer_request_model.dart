class TimerRequestModel {
  TimerRequestModel({
    required this.workDuration,
    required this.breakDuration,
    required this.setCount,
    required this.autoPlay,
  });
  final int workDuration;
  final int breakDuration;
  final int setCount;
  final bool autoPlay;

  factory TimerRequestModel.fromJson(Map<String, dynamic> json) {
    return TimerRequestModel(
      workDuration: json['workDuration'],
      breakDuration: json['breakDuration'],
      setCount: json['setCount'],
      autoPlay: json['autoPlay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'setCount': setCount,
      'autoPlay': autoPlay,
    };
  }
}
