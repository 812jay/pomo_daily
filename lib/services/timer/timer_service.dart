import 'package:hive/hive.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request.dart';
import 'package:pomo_daily/data/models/timer/res/local/timer_local.dart';

class TimerService {
  Future<void> setTimer(TimerRequest payload) async {
    // print('payload: ${payload.toJson()}');
    final settingBox = await Hive.openBox('setting');
    settingBox.put('timer', payload.toJson());
  }

  Future<TimerLocal> getTimer() async {
    final defaultWorkDuration = 25 * 60;
    final defaultBreakDuration = 5 * 60;
    final defaultSets = 5;
    try {
      final settingBox = await Hive.openBox('setting');
      final timerSetting = Map<String, dynamic>.from(
        settingBox.get(
          'timer',
          defaultValue: {
            'workDuration': defaultWorkDuration,
            'breakDuration': defaultBreakDuration,
            'setCount': defaultSets,
          },
        ),
      );

      return TimerLocal(
        duration: timerSetting['workDuration'],
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: 1,
        totalSets: timerSetting['setCount'],
        completedSets: 0,
      );
    } catch (e, stackTrace) {
      print('Error in getTimerSetting: $e');
      print('Stack trace: $stackTrace');
      return TimerLocal(
        duration: defaultWorkDuration,
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: 1,
        totalSets: defaultSets,
        completedSets: 0,
      );
    }
  }

  Future<void> clearTimer() async {
    final settingBox = await Hive.openBox('setting');
    // 방법 1: 특정 키만 삭제
    await settingBox.delete('timer');
  }
}
