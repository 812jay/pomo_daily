import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request.dart';
import 'package:pomo_daily/data/models/timer/res/local/timer_local.dart';
import 'package:pomo_daily/services/base_storage_service.dart';

class TimerService extends BaseStorageService {
  static const String _timerKey = 'timer';
  static const int _defaultWorkDuration = 25 * 60;
  static const int _defaultBreakDuration = 5 * 60;
  static const int _defaultSets = 5;

  Future<void> setTimer(TimerRequest payload) async {
    await setValue(_timerKey, payload.toJson());
  }

  Future<Map<String, dynamic>> getTimerSettings() async {
    final defaultSettings = {
      'workDuration': _defaultWorkDuration,
      'breakDuration': _defaultBreakDuration,
      'setCount': _defaultSets,
    };

    final Map rawSettings = await getValue<Map>(_timerKey, defaultSettings);

    return Map<String, dynamic>.from(rawSettings);
  }

  Future<void> clearTimer() async {
    await deleteValue(_timerKey);
  }

  TimerLocal createInitialState(Map<String, dynamic> settings) {
    return TimerLocal(
      duration: settings['workDuration'] as int,
      status: TimerStatus.initial,
      mode: TimerMode.work,
      currentSet: 1,
      totalSets: settings['setCount'] as int,
      completedSets: 0,
    );
  }
}
