import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

class DishCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;

  // Receives the global position where More was pressed
  final ValueChanged<Offset>? onMoreTap;

  const DishCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.dishCardRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.dishCardRadius),
        child: SizedBox(
          height: AppDimens.dishCardHeight,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Dish image
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: AppColors.searchBackground,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              // Bottom gradient overlay
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black45,
                      ],
                      stops: [0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Dish name + More button
              Positioned(
                left: 16,
                right: 16,
                bottom: 14,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.dishTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),

                    _MoreBadge(
                      onTap: onMoreTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreBadge extends StatelessWidget {
  final ValueChanged<Offset>? onTap;

  const _MoreBadge({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (details) {
        onTap?.call(details.globalPosition);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.imageOverlay,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'More',
          style: AppTextStyles.moreButton,
        ),
      ),
    );
  }
}