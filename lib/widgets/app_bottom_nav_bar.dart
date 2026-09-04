import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNavBar({
    super.key,
    this.currentIndex = 2,
    this.onTap,
  });

  static const List<_NavItemData> _items = [
    _NavItemData(icon: Icons.home_outlined, label: 'Home'),
    _NavItemData(icon: Icons.search, label: 'Search'),
    _NavItemData(icon: Icons.explore_outlined, label: 'Explore'),
    _NavItemData(icon: Icons.bookmark_outline, label: 'Favorites'),
    _NavItemData(icon: Icons.calendar_today_outlined, label: 'Calendar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.navBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final bool isSelected = index == currentIndex;
          final Color color =
              isSelected ? AppColors.navSelected : AppColors.navUnselected;

          return InkWell(
            onTap: () => onTap?.call(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: AppDimens.navIconSize, color: color),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: AppTextStyles.navLabel.copyWith(color: color),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData({required this.icon, required this.label});
}
