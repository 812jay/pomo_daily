// 타이머 상태를 담는 클래스
import 'package:pomo_daily/data/enums/timer/timer_type.dart';

class TimerLocal {
  final int duration; // 초 단위로 저장 (int로 변경)
  final TimerStatus status;
  final TimerMode mode;
  final int currentSet; // 현재 세트
  final int totalSets; // 총 세트
  final int completedSets; // 완료한 세트

  TimerLocal({
    required this.duration,
    required this.status,
    required this.mode,
    required this.currentSet,
    required this.totalSets,
    required this.completedSets,
  });

  TimerLocal copyWith({
    int? duration,
    TimerStatus? status,
    TimerMode? mode,
    int? currentSet,
    int? totalSets,
    int? completedSets,
  }) {
    return TimerLocal(
      duration: duration ?? this.duration,
      status: status ?? this.status,
      mode: mode ?? this.mode,
      currentSet: currentSet ?? this.currentSet,
      totalSets: totalSets ?? this.totalSets,
      completedSets: completedSets ?? this.completedSets,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'status': status.index, // enum의 index를 저장
      'mode': mode.index, // enum의 index를 저장
      'currentSet': currentSet,
      'totalSets': totalSets,
      'completedSets': completedSets,
    };
  }

  // JSON에서 모델 생성 팩토리 메서드 추가
  factory TimerLocal.fromJson(Map<String, dynamic> json) {
    return TimerLocal(
      duration: json['duration'] as int,
      status: TimerStatus.values[json['status'] as int],
      mode: TimerMode.values[json['mode'] as int],
      currentSet: json['currentSet'] as int,
      totalSets: json['totalSets'] as int,
      completedSets: json['completedSets'] as int,
    );
  }
}
