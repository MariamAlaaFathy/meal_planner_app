import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

class CategoryListTile extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const CategoryListTile({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.categoryItemVerticalPadding,
        ),
        child: Row(
          children: [
            Container(
              width: AppDimens.categoryIconSize,
              height: AppDimens.categoryIconSize,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'A',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(width: AppDimens.categoryIconGap),
            Expanded(
              child: Text(name, style: AppTextStyles.categoryItem),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
