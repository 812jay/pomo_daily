import 'package:hive/hive.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request.dart';
import 'package:pomo_daily/data/models/timer/res/local/timer_local.dart';

class SettingService {
  Future<void> setTimerSetting(TimerRequest payload) async {
    // print('payload: ${payload.toJson()}');
    final settingBox = await Hive.openBox('setting');
    settingBox.put('timer', payload.toJson());
  }

  Future<TimerLocal> getTimerSetting() async {
    try {
      final settingBox = await Hive.openBox('setting');
      final timerSetting = Map<String, dynamic>.from(
        settingBox.get(
          'timer',
          defaultValue: {
            'workSeconds': 25 * 60,
            'breakSeconds': 5 * 60,
            'totalSetCount': 5,
          },
        ),
      );

      return TimerLocal(
        duration: timerSetting['workSeconds'],
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: 1,
        totalSets: timerSetting['totalSetCount'],
        completedSets: 0,
      );
    } catch (e, stackTrace) {
      print('Error in getTimerSetting: $e');
      print('Stack trace: $stackTrace');
      return TimerLocal(
        duration: 25 * 60,
        status: TimerStatus.initial,
        mode: TimerMode.work,
        currentSet: 1,
        totalSets: 5,
        completedSets: 0,
      );
    }
  }

  Future<void> clearTimerSetting() async {
    final settingBox = await Hive.openBox('setting');
    // 방법 1: 특정 키만 삭제
    await settingBox.delete('timer');
  }
}
