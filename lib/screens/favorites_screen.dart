import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/dish_card.dart';
import '../widgets/dish_more_menu.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<void> _handleMoreTap(
    BuildContext context,
    Offset globalPosition,
    Dish dish,
  ) async {
    await DishMoreMenu.show(
      context: context,
      globalPosition: globalPosition,
      onAddToCalendar: () {
        // TODO: اربطيها بمنطق إضافة الطبق للكالندر.
      },
      onRemoveFromFavorites: () {
        context.read<FavoritesProvider>().removeFavorite(dish.id);
      },
      onShare: () {
        // TODO: اربطيها بمنطق المشاركة.
      },
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
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favorites Tab',
                  style: AppTextStyles.screenTitle,
                ),
              ),
            ),
            Expanded(
              child: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, _) {
                  final favoriteDishes = favoritesProvider.favorites;

                  if (favoriteDishes.isEmpty) {
                    return const _EmptyFavorites();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.screenPaddingH,
                      8,
                      AppDimens.screenPaddingH,
                      16,
                    ),
                    itemCount: favoriteDishes.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: AppDimens.dishCardGap,
                    ),
                    itemBuilder: (context, index) {
                      final dish = favoriteDishes[index];

                      return DishCard(
                        name: dish.name,
                        imageUrl: dish.imageUrl,
                        onTap: () {
                          // TODO: افتحي شاشة تفاصيل الطبق لو موجودة.
                        },
                        onMoreTap: (globalPosition) {
                          _handleMoreTap(
                            context,
                            globalPosition,
                            dish,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No favorites yet',
        style: AppTextStyles.screenSubtitle,
      ),
    );
  }
}
