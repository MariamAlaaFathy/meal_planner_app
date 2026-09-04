import 'package:flutter/material.dart';
import '../models/food_category.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/category_list_tile.dart';
import 'category_detail_screen.dart';

class ExploreCategoriesScreen extends StatefulWidget {
  const ExploreCategoriesScreen({super.key});

  @override
  State<ExploreCategoriesScreen> createState() =>
      _ExploreCategoriesScreenState();
}

class _ExploreCategoriesScreenState extends State<ExploreCategoriesScreen> {
  // 0 = Categories, 1 = Cuisines
  int _selectedTab = 0;

  void _openCategory(FoodCategory category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoryDetailScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.screenPaddingH,
                AppDimens.screenPaddingTop,
                AppDimens.screenPaddingH,
                8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Explore Tab', style: AppTextStyles.screenTitle),
                ],
              ),
            ),

            // Categories / Cuisines tabs
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.screenPaddingH,
              ),
              child: _buildTabs(),
            ),
            const SizedBox(height: 16),

            // Search box
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.screenPaddingH,
              ),
              child: _buildSearchBox(),
            ),
            const SizedBox(height: 8),

            // Categories list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.screenPaddingH,
                ),
                itemCount: dummyCategories.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (context, index) {
                  final category = dummyCategories[index];
                  return CategoryListTile(
                    name: category.name,
                    onTap: () => _openCategory(category),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _TabButton(
          label: 'Categories',
          isSelected: _selectedTab == 0,
          onTap: () => setState(() => _selectedTab = 0),
        ),
        const SizedBox(width: 28),
        _TabButton(
          label: 'Cuisines',
          isSelected: _selectedTab == 1,
          onTap: () => setState(() => _selectedTab = 1),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return Container(
      height: AppDimens.searchBoxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.searchBackground,
        borderRadius: BorderRadius.circular(AppDimens.searchBoxRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: AppTextStyles.searchHint,
                border: InputBorder.none,
                isDense: true,
              ),
              style: AppTextStyles.searchHint.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(Icons.search, color: AppColors.textSecondary, size: 22),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.tabLabel.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 70,
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
