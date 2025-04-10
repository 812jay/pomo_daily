class TimerConfigModel {
  final double workDuration;
  final double breakDuration;
  final double setCount;
  final bool autoPlay;

  const TimerConfigModel({
    required this.workDuration,
    required this.breakDuration,
    required this.setCount,
    required this.autoPlay,
  });

  TimerConfigModel copyWith({
    double? workDuration,
    double? breakDuration,
    double? setCount,
    bool? autoPlay,
  }) {
    return TimerConfigModel(
      workDuration: workDuration ?? this.workDuration,
      breakDuration: breakDuration ?? this.breakDuration,
      setCount: setCount ?? this.setCount,
      autoPlay: autoPlay ?? this.autoPlay,
    );
  }

  // fromJson 메서드 추가
  factory TimerConfigModel.fromJson(Map<String, dynamic> json) {
    return TimerConfigModel(
      workDuration: (json['workDuration'] as num).toDouble(),
      breakDuration: (json['breakDuration'] as num).toDouble(),
      setCount: (json['setCount'] as num).toDouble(),
      autoPlay: json['autoPlay'] as bool,
    );
  }

  // toJson 메서드 추가
  Map<String, dynamic> toJson() {
    return {
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'setCount': setCount,
      'autoPlay': autoPlay,
    };
  }
}
