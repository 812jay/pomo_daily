import 'package:flutter/foundation.dart';

/// 로그 레벨 정의
enum LogLevel {
  verbose, // 가장 상세한 로그
  debug, // 디버깅용 로그
  info, // 정보성 로그
  warning, // 경고 로그
  error, // 에러 로그
  none, // 로그를 출력하지 않음
}

/// 로그 유틸리티 클래스
class AppLogger {
  // private 생성자
  AppLogger._();

  // 현재 로그 레벨 (기본값: 디버그 모드에서는 debug, 릴리즈 모드에서는 warning)
  static LogLevel _currentLevel =
      kDebugMode ? LogLevel.debug : LogLevel.warning;

  // 로그 태그 접두사 (앱 이름 등으로 설정 가능)
  static String _prefix = 'PomoDaily';

  /// 로그 레벨 설정
  static void setLevel(LogLevel level) {
    _currentLevel = level;
  }

  /// 로그 접두사 설정
  static void setPrefix(String prefix) {
    _prefix = prefix;
  }

  /// verbose 로그
  static void v(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.verbose,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// debug 로그
  static void d(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.debug,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// info 로그
  static void i(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.info,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// warning 로그
  static void w(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.warning,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// error 로그
  static void e(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 로그 출력 핵심 메서드
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    // 현재 설정된 레벨보다 낮은 레벨의 로그는 출력하지 않음
    if (level.index < _currentLevel.index) {
      return;
    }

    // 로그 레벨에 따른 접두사 설정
    String levelPrefix;
    switch (level) {
      case LogLevel.verbose:
        levelPrefix = '💬 V';
        break;
      case LogLevel.debug:
        levelPrefix = '🐛 D';
        break;
      case LogLevel.info:
        levelPrefix = 'ℹ️ I';
        break;
      case LogLevel.warning:
        levelPrefix = '⚠️ W';
        break;
      case LogLevel.error:
        levelPrefix = '🔴 E';
        break;
      default:
        levelPrefix = '';
    }

    // 로그 형식: [앱이름] 레벨 [태그] 메시지
    // 태그가 null이면 태그 부분 생략
    final logMessage =
        tag == null
            ? '[$_prefix] $levelPrefix $message'
            : '[$_prefix] $levelPrefix [${tag.toUpperCase()}] $message';

    // 실제 로그 출력 (print는 릴리즈 모드에서 제거됨)
    debugPrint(logMessage);

    // 에러와 스택 트레이스가 있을 경우 추가 출력
    if (error != null) {
      debugPrint('[$_prefix] Error: $error');
      if (stackTrace != null) {
        debugPrint('[$_prefix] StackTrace: $stackTrace');
      }
    }
  }

  /// 성능 측정 시작
  static Stopwatch startPerformanceLog(String operation, {String? tag}) {
    final stopwatch = Stopwatch()..start();
    d('⏱️ Started: $operation', tag: tag);
    return stopwatch;
  }

  /// 성능 측정 종료 및 결과 출력
  static void endPerformanceLog(
    String operation,
    Stopwatch stopwatch, {
    String? tag,
  }) {
    stopwatch.stop();
    d(
      '⏱️ Completed: $operation in ${stopwatch.elapsedMilliseconds}ms',
      tag: tag,
    );
  }
}

// 참고: 글로벌 로거 인스턴스가 더 이상 필요 없음 (정적 메서드 사용)
// final logger = AppLogger();
