import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request_model.dart';
import 'package:pomo_daily/data/models/timer/res/timer_state_model.dart';
import 'package:pomo_daily/services/timer_service.dart';
import 'package:pomo_daily/services/vibration_service.dart';

import 'package:vibration/vibration.dart';

final timerServiceProvider = Provider((ref) => TimerService());
final vibrationServiceProvider = Provider((ref) => VibrationService());

// 타이머 뷰모델
class TimerState extends AsyncNotifier<TimerStateModel> {
  static bool _isInitialized = false;
  Timer? _timer;
  late int workDuration;
  late int breakDuration;
  late int totalSets;
  late bool autoPlay;
  late VibrationService _vibrationService;
  late TimerService _timerService;

  @override
  Future<TimerStateModel> build() async {
    _vibrationService = ref.read(vibrationServiceProvider);
    _timerService = ref.read(timerServiceProvider);

    if (!_isInitialized) {
      await _timerService.initializeTimerSetting();
      _isInitialized = true;
    }

    final TimerStateModel timerState = await getTimerSetting();
    return timerState;
  }

  Future<TimerStateModel> getTimerSetting() async {
    final timerConfig = await _timerService.getTimerSettings();

    // 클래스 변수들 초기화 추가
    workDuration = timerConfig.workDuration.toInt();
    breakDuration = timerConfig.breakDuration.toInt();
    totalSets = timerConfig.setCount.toInt();
    autoPlay = timerConfig.autoPlay;

    return _timerService.getInitialState(timerConfig);
  }

  // 설정 저장 메서드
  Future<void> saveSettings() async {
    _timer?.cancel();
    final request = TimerRequestModel(
      workDuration: workDuration,
      breakDuration: breakDuration,
      setCount: totalSets,
      autoPlay: autoPlay,
    );

    // 설정 저장
    await _timerService.setTimer(request);

    // 현재 상태 리셋
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(
        TimerStateModel(
          duration: workDuration,
          status: TimerStatus.initial,
          mode: TimerMode.work,
          currentSet: 1,
          totalSets: totalSets,
          completedSets: 0,
          autoPlay: currentState.autoPlay,
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
      TimerStateModel(
        duration: workDuration,
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: 1,
        totalSets: currentState.totalSets,
        completedSets: 0,
        autoPlay: currentState.autoPlay,
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
      final newCompletedSets = currentState.completedSets + 1;

      if (newCompletedSets >= currentState.totalSets) {
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
            status: autoPlay ? TimerStatus.running : TimerStatus.paused,
            mode: TimerMode.shortBreak,
            completedSets: newCompletedSets,
          ),
        );
        // autoPlay가 true일 때만 타이머 시작
        if (autoPlay) {
          _timer = Timer.periodic(
            const Duration(seconds: 1),
            (_) => _countdown(),
          );
        }
      }
    } else {
      // 작업 시간으로 전환
      state = AsyncData(
        currentState.copyWith(
          duration: workDuration,
          status: autoPlay ? TimerStatus.running : TimerStatus.paused,
          mode: TimerMode.work,
          currentSet: currentState.currentSet + 1,
        ),
      );
      // autoPlay가 true일 때만 타이머 시작
      if (autoPlay) {
        _timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) => _countdown(),
        );
      }
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

  void setAutoPlay(bool autoPlay) {
    this.autoPlay = autoPlay;
    state = AsyncData(state.value!.copyWith(autoPlay: autoPlay));
  }
}

// Provider 정의
final timerProvider = AsyncNotifierProvider<TimerState, TimerStateModel>(
  () => TimerState(),
);
