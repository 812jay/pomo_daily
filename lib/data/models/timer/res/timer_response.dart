class TimerResponse {
  final int workSeconds;
  final int breakSeconds;
  final int totalSetCount;

  TimerResponse({
    required this.workSeconds,
    required this.breakSeconds,
    required this.totalSetCount,
  });

  factory TimerResponse.fromJson(Map<String, dynamic> json) {
    return TimerResponse(
      workSeconds: json['workSeconds'],
      breakSeconds: json['breakSeconds'],
      totalSetCount: json['totalSetCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workSeconds': workSeconds,
      'breakSeconds': breakSeconds,
      'totalSetCount': totalSetCount,
    };
  }
}
