class TimerResponse {
  final int workDuration;
  final int breakDuration;
  final int setCount;

  TimerResponse({
    required this.workDuration,
    required this.breakDuration,
    required this.setCount,
  });

  factory TimerResponse.fromJson(Map<String, dynamic> json) {
    return TimerResponse(
      workDuration: json['workDuration'],
      breakDuration: json['breakDuration'],
      setCount: json['setCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'setCount': setCount,
    };
  }
}
