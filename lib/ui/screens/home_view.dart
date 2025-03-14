// lib/features/home/ui/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/app_colors.dart';
import 'package:pomo_daily/ui/screens/setting_view.dart';
import 'package:pomo_daily/ui/screens/timer_view.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/%08providers/bottom_nav_provider.dart'; // Import the HomeState

class HomeView extends ConsumerWidget {
  const HomeView({super.key});
  // 페이지 리스트 (index에 따라 보여줄 화면 결정)
  static final List<Widget> _pages = [TimerView(), SettingView()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'timer',
            icon: SvgIcon(
              iconName: 'timer',
              size: 24,
              iconColor:
                  selectedIndex == 0
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
            ),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: SvgIcon(
              iconName: 'settings',
              size: 24,
              iconColor:
                  selectedIndex == 1
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
            ),
          ),
        ],
        currentIndex: selectedIndex, // Set the current index
        selectedItemColor:
            AppColors.textPrimary, // Color for selected item label
        unselectedItemColor:
            AppColors.textSecondary, // Color for unselected item label
        onTap:
            (index) => ref
                .read(bottomNavProvider.notifier)
                .selectIndex(index), // Update the selected index
      ),
    );
  }
}
