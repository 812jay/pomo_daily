class TimerRequest {
  TimerRequest({
    required this.workDuration,
    required this.breakDuration,
    required this.setCount,
  });
  final int workDuration;
  final int breakDuration;
  final int setCount;

  factory TimerRequest.fromJson(Map<String, dynamic> json) {
    return TimerRequest(
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
