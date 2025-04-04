import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request_model.dart';
import 'package:pomo_daily/data/models/timer/res/timer_state_model.dart';
import 'package:pomo_daily/data/models/timer/res/timer_config_model.dart';
import 'package:pomo_daily/services/base_storage_service.dart';

class TimerService extends BaseStorageService {
  static const String _timerKey = 'timer';
  static const int _defaultWorkDuration = 25 * 60;
  static const int _defaultBreakDuration = 5 * 60;
  static const int _defaultSets = 5;
  static const bool _defaultAutoPlay = false;

  Future<void> setTimer(TimerRequestModel payload) async {
    await setValue(_timerKey, payload.toJson());
  }

  Future<TimerConfigModel> getTimerSettings() async {
    final defaultSettings = {
      'workDuration': _defaultWorkDuration,
      'breakDuration': _defaultBreakDuration,
      'setCount': _defaultSets,
      'autoPlay': _defaultAutoPlay,
    };

    final Map rawSettings = await getValue<Map>(_timerKey, defaultSettings);

    return TimerConfigModel(
      workDuration: (rawSettings['workDuration'] as int).toDouble(),
      breakDuration: (rawSettings['breakDuration'] as int).toDouble(),
      setCount: (rawSettings['setCount'] as int).toDouble(),
      autoPlay: rawSettings['autoPlay'] as bool,
    );
  }

  Future<void> clearTimer() async {
    await deleteValue(_timerKey);
  }

  TimerStateModel createInitialState(TimerConfigModel settings) {
    return TimerStateModel(
      duration: settings.workDuration.toInt(),
      status: TimerStatus.initial,
      mode: TimerMode.work,
      currentSet: 1,
      totalSets: settings.setCount.toInt(),
      completedSets: 0,
      autoPlay: settings.autoPlay,
    );
  }
}
