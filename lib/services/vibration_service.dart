import 'package:pomo_daily/services/base_storage_service.dart';

class VibrationService extends BaseStorageService {
  static const String _vibrationKey = 'isVibration';

  Future<void> initializeVibrationSetting() async {
    final box = await openBox();
    if (!box.containsKey(_vibrationKey)) {
      await setValue(_vibrationKey, false);
    }
  }

  Future<void> setVibration(bool isVibration) async {
    await setValue(_vibrationKey, isVibration);
  }

  Future<bool> getVibration() async {
    return await getValue(_vibrationKey, false);
  }
}
