import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomo_daily/config/theme/custom_colors.dart';
import 'package:pomo_daily/ui/screens/setting/setting_view.dart';
import 'package:pomo_daily/ui/screens/timer_view.dart';
import 'package:pomo_daily/ui/widgets/common/svg_icon.dart';
import 'package:pomo_daily/providers/bottom_nav_provider.dart'; // Import the HomeState
import 'package:pomo_daily/generated/l10n/app_localizations.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: PageContent(selectedIndex: selectedIndex),
      bottomNavigationBar: HomeNavigationBar(
        selectedIndex: selectedIndex,
        onIndexChanged:
            (index) => ref.read(bottomNavProvider.notifier).selectIndex(index),
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({required this.selectedIndex, super.key});

  final int selectedIndex;
  static final List<Widget> _pages = [TimerView(), SettingView()];

  @override
  Widget build(BuildContext context) {
    return _pages[selectedIndex];
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    required this.selectedIndex,
    required this.onIndexChanged,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      backgroundColor: context.colors.background,
      items: [
        NavigationBarItem(
          context: context,
          label: l10n.timer,
          iconName: 'timer',
          isSelected: selectedIndex == 0,
        ),
        NavigationBarItem(
          context: context,
          label: l10n.settings,
          iconName: 'settings',
          isSelected: selectedIndex == 1,
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onIndexChanged,
      selectedItemColor: context.colors.iconPrimary,
      unselectedItemColor: context.colors.iconSecondary,
    );
  }
}

class NavigationBarItem extends BottomNavigationBarItem {
  NavigationBarItem({
    required String label,
    required String iconName,
    required bool isSelected,
    required BuildContext context,
  }) : super(
         label: label,
         icon: SvgIcon(
           iconName: iconName,
           size: 24,
           iconColor:
               isSelected
                   ? context.colors.iconPrimary
                   : context.colors.iconSecondary,
         ),
       );
}
