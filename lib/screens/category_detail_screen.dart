import 'package:flutter/material.dart';
import '../models/dish.dart';
import '../models/food_category.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/dish_card.dart';

class CategoryDetailScreen extends StatelessWidget {
  final FoodCategory category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                8,
                AppDimens.screenPaddingTop,
                AppDimens.screenPaddingH,
                8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    color: AppColors.textPrimary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(category.name, style: AppTextStyles.screenTitle),
                        const SizedBox(height: 2),
                        const Text(
                          'Category',
                          style: AppTextStyles.screenSubtitle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.screenPaddingH,
                  8,
                  AppDimens.screenPaddingH,
                  16,
                ),
                itemCount: dummyDishes.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: AppDimens.dishCardGap),
                itemBuilder: (context, index) {
                  final dish = dummyDishes[index];
                  return DishCard(
                    name: dish.name,
                    imageUrl: dish.imageUrl,
                    onTap: () {},
                    onMoreTap: (globalPsition) {},
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
}
