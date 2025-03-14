import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavNotifier extends StateNotifier<int> {
  BottomNavNotifier() : super(0); // Initialize with the first index (0)

  void selectIndex(int index) {
    state = index; // Update the selected index
  }
}

// Provider definition
final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, int>((ref) {
  return BottomNavNotifier();
});
