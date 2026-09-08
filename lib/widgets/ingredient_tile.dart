import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class IngredientTile extends StatelessWidget {
  final Ingredient ingredient;
  final ValueChanged<bool?>? onChanged;

  const IngredientTile({
    super.key,
    required this.ingredient,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: ingredient.isChecked,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: AppColors.border, width: 1.5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ingredient.name, style: AppTextStyles.categoryItem),
                const SizedBox(height: 2),
                Text(ingredient.quantity, style: AppTextStyles.screenSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
