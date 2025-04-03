import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request.dart';
import 'package:pomo_daily/data/models/timer/res/local/timer_local.dart';
import 'package:pomo_daily/services/timer_service.dart';
import 'package:pomo_daily/services/vibration_service.dart';

import 'package:vibration/vibration.dart';

final timerServiceProvider = Provider((ref) => TimerService());

// 타이머 뷰모델
class TimerState extends AsyncNotifier<TimerLocal> {
  Timer? _timer;
  late int workDuration;
  late int breakDuration;
  late int totalSets;
  late VibrationService _vibrationService;
  late TimerService _timerService;

  @override
  Future<TimerLocal> build() async {
    _timerService = ref.read(timerServiceProvider);
    final TimerLocal timerSetting = await setTimerSetting();

    return timerSetting;
  }

  Future<TimerLocal> setTimerSetting() async {
    final timerSetting = await _timerService.getTimerSettings();
    workDuration = timerSetting['workDuration'] as int;
    breakDuration = timerSetting['breakDuration'] as int;
    totalSets = timerSetting['setCount'] as int;

    return _timerService.createInitialState(timerSetting);
  }

  // 설정 저장 메서드
  Future<void> saveSettings() async {
    final payload = TimerRequest(
      workDuration: workDuration,
      breakDuration: breakDuration,
      setCount: totalSets,
    );

    // 설정 저장
    await _timerService.setTimer(payload);

    // 현재 상태 리셋
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(
        TimerLocal(
          duration: workDuration, // 새로 설정된 workDuration 사용
          status: TimerStatus.initial,
          mode: TimerMode.work, // 작업 모드로 초기화
          currentSet: 1, // 첫 번째 세트로 초기화
          totalSets: totalSets, // 새로 설정된 totalSets 사용
          completedSets: 0, // 완료된 세트 초기화
        ),
      );
    }
  }

  // 타이머 시작
  Future<void> start() async {
    final currentState = state.value!;
    if (currentState.status == TimerStatus.initial ||
        currentState.status == TimerStatus.paused) {
      state = AsyncData(currentState.copyWith(status: TimerStatus.running));
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _countdown());
    }
  }

  // 타이머 일시정지
  Future<void> pause() async {
    _timer?.cancel();
    final currentState = state.value!;
    state = AsyncData(currentState.copyWith(status: TimerStatus.paused));
  }

  // 타이머 리셋
  Future<void> reset() async {
    _timer?.cancel();
    final currentState = state.value!;
    state = AsyncData(
      TimerLocal(
        duration: workDuration,
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: 1,
        totalSets: currentState.totalSets,
        completedSets: 0,
      ),
    );
  }

  // 시간 포맷 함수
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // 세트 수 설정
  void setWorkDuration(double workDuration) {
    this.workDuration = workDuration.truncate() * 60;
  }

  void setBreakDuration(double breakDuration) {
    this.breakDuration = breakDuration.truncate() * 60;
  }

  void setTotalSets(double totalSets) {
    this.totalSets = totalSets.truncate();
  }

  // 카운트다운 로직
  void _countdown() {
    final currentState = state.value!;
    if (currentState.duration > 0) {
      state = AsyncData(
        currentState.copyWith(duration: currentState.duration - 1),
      );
    } else {
      _timer?.cancel();
      _handleSetCompletion();
    }
  }

  // 세트 완료 처리
  Future<void> _handleSetCompletion() async {
    final currentState = state.value!;
    if (currentState.mode == TimerMode.work) {
      // 작업 시간이 끝났을 때
      final newCompletedSets = currentState.completedSets + 1;

      if (newCompletedSets >= currentState.totalSets) {
        // 모든 세트가 완료됨
        state = AsyncData(
          currentState.copyWith(
            status: TimerStatus.finished,
            completedSets: newCompletedSets,
          ),
        );
      } else {
        // 휴식 시간으로 전환
        state = AsyncData(
          currentState.copyWith(
            duration: breakDuration,
            status: TimerStatus.initial,
            mode: TimerMode.shortBreak,
            completedSets: newCompletedSets,
          ),
        );
      }
    } else {
      // 휴식 시간이 끝났을 때
      state = AsyncData(
        currentState.copyWith(
          duration: workDuration,
          status: TimerStatus.initial,
          mode: TimerMode.work,
          currentSet: currentState.currentSet + 1,
        ),
      );
    }
    await vibrate();
  }

  // 다음 세트로 건너뛰기
  Future<void> skipToNextSet() async {
    _timer?.cancel(); // 현재 타이머를 중지합니다.
    _handleSetCompletion();
  }

  Future<void> vibrate() async {
    if (await Vibration.hasVibrator() &&
        await _vibrationService.getVibration()) {
      await Vibration.vibrate(duration: 700);
    }
  }
}

// Provider 정의
final timerProvider = AsyncNotifierProvider<TimerState, TimerLocal>(
  () => TimerState(),
);
