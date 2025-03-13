// 타이머 모드를 나타내는 열거형
enum TimerMode { work, shortBreak }

extension TimerModeExtension on TimerMode {
  String get comment {
    switch (this) {
      case TimerMode.work:
        return 'WORK';
      case TimerMode.shortBreak:
        return 'BREAK';
    }
  }

  bool get isWork => this == TimerMode.work;
  bool get isShortBreak => this == TimerMode.shortBreak;
}

// 타이머 상태를 나타내는 열거형
enum TimerStatus { initial, running, paused, finished }

extension TimerStatusExtension on TimerStatus {
  bool get isPaused => this == TimerStatus.paused;
  bool get isRunning => this == TimerStatus.running;
  bool get isFinished => this == TimerStatus.finished;
}
