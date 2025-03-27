import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void selectIndex(int index) {
    state = index; // Update the selected index
  }
}

// Provider definition
final bottomNavProvider = NotifierProvider<BottomNavNotifier, int>(
  () => BottomNavNotifier(),
);
