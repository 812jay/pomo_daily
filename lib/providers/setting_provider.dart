import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/services/setting/setting_service.dart';
import 'package:pomo_daily/utils/logger.dart';

final settingServiceProvider = Provider((ref) => SettingService());

class SettingState extends AsyncNotifier<bool> {
  late SettingService _settingService;

  @override
  Future<bool> build() async {
    _settingService = ref.read(settingServiceProvider);
    final isVibration = await _settingService.getVibration();
    return isVibration;
  }

  Future<void> toggleVibration(bool currentValue) async {
    // 상태를 로딩 상태로 설정
    state = const AsyncLoading();

    try {
      // 현재 값의 반대 값을 Hive에 저장
      final newValue = !currentValue;
      await _settingService.setVibration(newValue);

      // Hive에서 저장된 값을 다시 읽어옴 (확인용)
      final savedValue = await _settingService.getVibration();

      // 로그 추가 (디버깅용)
      AppLogger.debug('진동 설정이 변경되었습니다. 새 값: $savedValue', tag: 'SettingState');

      // 상태 업데이트
      state = AsyncData(savedValue);
    } catch (e, stackTrace) {
      AppLogger.error(
        '진동 설정 변경 중 오류 발생',
        error: e,
        stackTrace: stackTrace,
        tag: 'SettingState',
      );
      state = AsyncError(e, stackTrace);
    }
  }
}

final settingProvider = AsyncNotifierProvider<SettingState, bool>(
  () => SettingState(),
);
