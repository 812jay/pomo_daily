class TimerResponse {
  final int workDuration;
  final int breakDuration;
  final int setCount;
  final bool autoPlay;

  TimerResponse({
    required this.workDuration,
    required this.breakDuration,
    required this.setCount,
    required this.autoPlay,
  });

  factory TimerResponse.fromJson(Map<String, dynamic> json) {
    return TimerResponse(
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
