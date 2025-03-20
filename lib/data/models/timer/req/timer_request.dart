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
      workDuration: json['workSeconds'],
      breakDuration: json['breakSeconds'],
      setCount: json['setCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workSeconds': workDuration,
      'breakSeconds': breakDuration,
      'totalSetCount': setCount,
    };
  }
}
