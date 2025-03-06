import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/enum/timer/timer_type.dart';
import 'package:pomo_daily/model/timer/timer_model.dart';

// 타이머 뷰모델
class TimerViewModel extends StateNotifier<TimerState> {
  Timer? _timer;
  static const int workDuration = 25 * 60; // 25분
  static const int breakDuration = 5 * 60; // 5분
  static const int defaultTotalSets = 4; // 기본 세트 수

  TimerViewModel()
    : super(
        TimerState(
          duration: workDuration,
          status: TimerStatus.initial,
          mode: TimerMode.work,
          currentSet: 1,
          totalSets: defaultTotalSets,
          completedSets: 0,
        ),
      );

  // 타이머 시작
  void start() {
    if (state.status == TimerStatus.initial ||
        state.status == TimerStatus.paused) {
      state = state.copyWith(status: TimerStatus.running);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _countdown());
    }
  }

  // 타이머 일시정지
  void pause() {
    _timer?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  // 타이머 리셋
  void reset() {
    _timer?.cancel();
    state = TimerState(
      duration: workDuration,
      status: TimerStatus.initial,
      mode: TimerMode.work,
      currentSet: 1,
      totalSets: state.totalSets,
      completedSets: 0,
    );
  }

  // 모드 전환
  void toggleMode() {
    _timer?.cancel();
    state = TimerState(
      duration: state.mode == TimerMode.work ? breakDuration : workDuration,
      status: TimerStatus.initial,
      mode:
          state.mode == TimerMode.work ? TimerMode.shortBreak : TimerMode.work,
      currentSet: state.currentSet,
      totalSets: state.totalSets,
      completedSets: state.completedSets,
    );
  }

  // 시간 포맷 함수
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // 세트 수 설정
  void setTotalSets(int sets) {
    if (state.status == TimerStatus.initial) {
      state = state.copyWith(totalSets: sets);
    }
  }

  // 카운트다운 로직
  void _countdown() {
    if (state.duration > 0) {
      state = state.copyWith(duration: state.duration - 1);
    } else {
      _timer?.cancel();
      _handleSetCompletion();
    }
  }

  // 세트 완료 처리
  void _handleSetCompletion() {
    if (state.mode == TimerMode.work) {
      // 작업 시간이 끝났을 때
      final newCompletedSets = state.completedSets + 1;

      if (newCompletedSets >= state.totalSets) {
        // 모든 세트가 완료됨
        state = state.copyWith(
          status: TimerStatus.finished,
          completedSets: newCompletedSets,
        );
      } else {
        // 휴식 시간으로 전환
        state = state.copyWith(
          duration: breakDuration,
          status: TimerStatus.initial,
          mode: TimerMode.shortBreak,
          completedSets: newCompletedSets,
        );
      }
    } else {
      // 휴식 시간이 끝났을 때
      state = state.copyWith(
        duration: workDuration,
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: state.currentSet + 1,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Provider 정의
final timerProvider = StateNotifierProvider<TimerViewModel, TimerState>(
  (ref) => TimerViewModel(),
);
