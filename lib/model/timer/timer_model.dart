// 타이머 상태를 담는 클래스
import 'package:pomo_daily/enum/timer/timer_type.dart';

class TimerState {
  final int duration;
  final TimerStatus status;
  final TimerMode mode;
  final int currentSet; // 현재 세트
  final int totalSets; // 총 세트
  final int completedSets; // 완료한 세트

  TimerState({
    required this.duration,
    required this.status,
    required this.mode,
    required this.currentSet,
    required this.totalSets,
    required this.completedSets,
  });

  // 상태 복사 메서드
  TimerState copyWith({
    int? duration,
    TimerStatus? status,
    TimerMode? mode,
    int? currentSet,
    int? totalSets,
    int? completedSets,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
      mode: mode ?? this.mode,
      currentSet: currentSet ?? this.currentSet,
      totalSets: totalSets ?? this.totalSets,
      completedSets: completedSets ?? this.completedSets,
    );
  }
}
