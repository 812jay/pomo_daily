import 'package:hive/hive.dart';
import 'package:pomo_daily/utils/logger.dart';

abstract class BaseStorageService {
  final String boxName;

  BaseStorageService({this.boxName = 'setting'});

  Future<Box> openBox() async {
    try {
      return await Hive.openBox(boxName);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error opening box: $boxName',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<T> getValue<T>(String key, T defaultValue) async {
    try {
      final box = await openBox();
      return box.get(key, defaultValue: defaultValue);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error getting value for key: $key',
        error: e,
        stackTrace: stackTrace,
      );
      return defaultValue;
    }
  }

  Future<void> setValue<T>(String key, T value) async {
    try {
      final box = await openBox();
      await box.put(key, value);
      AppLogger.info('Value updated for key: $key, value: $value');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error setting value for key: $key',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> deleteValue(String key) async {
    try {
      final box = await openBox();
      await box.delete(key);
      AppLogger.info('Value deleted for key: $key');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error deleting value for key: $key',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
