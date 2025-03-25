import 'package:hive/hive.dart';
import 'package:pomo_daily/data/enums/timer/timer_type.dart';
import 'package:pomo_daily/data/models/timer/req/timer_request.dart';
import 'package:pomo_daily/data/models/timer/res/local/timer_local.dart';
import 'package:pomo_daily/utils/logger.dart';

class SettingService {
  Future<void> setTimer(TimerRequest payload) async {
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
      AppLogger.error('Error in getTimerSetting: $e');
      AppLogger.error('Stack trace: $stackTrace');
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

  Future<void> initializeVibrationSetting() async {
    try {
      final settingBox = await Hive.openBox('setting');
      // 'isVibration' 키가 존재하는지 확인
      if (!settingBox.containsKey('isVibration')) {
        // 키가 없으면 (최초 설치) false로 설정
        await settingBox.put('isVibration', false);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error initializing vibration setting: $e');
      AppLogger.error('Stack trace: $stackTrace');
    }
  }

  Future<void> setVibration(bool isVibration) async {
    try {
      final settingBox = await Hive.openBox('setting');
      await settingBox.put('isVibration', isVibration);
      AppLogger.info('Vibration setting updated to: $isVibration');
    } catch (e, stackTrace) {
      AppLogger.error('Error setting vibration: $e');
      AppLogger.error('Stack trace: $stackTrace');
    }
  }

  Future<bool> getVibration() async {
    final settingBox = await Hive.openBox('setting');
    return settingBox.get('isVibration', defaultValue: false);
  }
}
