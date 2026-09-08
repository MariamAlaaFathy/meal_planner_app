import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../widgets/dish_more_menu.dart';
import '../widgets/ingredient_tile.dart';

class MealToPrepareScreen extends StatefulWidget {
  final Meal meal;

  const MealToPrepareScreen({super.key, required this.meal});

  @override
  State<MealToPrepareScreen> createState() => _MealToPrepareScreenState();
}

class _MealToPrepareScreenState extends State<MealToPrepareScreen> {
  late List<Ingredient> _ingredients;

  // ⚠️ حالة محلية مؤقتة لحد ما يبقى فيه Calendar Provider مشترك زي FavoritesProvider.
  // بما إن الوجبة هنا جايالك من الكالندر أصلاً (meal.source = "From your calendar")،
  // بنبدأها true. لو الوجبة ممكن متكونش في الكالندر من الأساس، غيّري القيمة الابتدائية دي
  // حسب بيانات الـ Meal الحقيقية.
  bool _isInCalendar = true;

  @override
  void initState() {
    super.initState();
    _ingredients = List.of(widget.meal.ingredients);
  }

  // بنحول الـ Meal لـ Dish بسيط عشان نقدر نستخدم نفس FavoritesProvider
  // المستخدم في باقي الشاشات (Explore, Category Detail, Favorites) من غير تكرار منطق.
  Dish get _asDish => Dish(
        id: widget.meal.id,
        name: widget.meal.name,
        imageUrl: widget.meal.imageUrl,
      );

  Future<void> _handleMenuTap(Offset globalPosition) async {
    final favoritesProvider = context.read<FavoritesProvider>();
    final isFavorite = favoritesProvider.isFavorite(_asDish.id);

    await DishMoreMenu.show(
      context: context,
      globalPosition: globalPosition,
      favoriteLabel:
          isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
      calendarLabel:
          _isInCalendar ? 'Remove from Calendar' : 'Add to Calendar',
      onAddToCalendar: () {
        setState(() => _isInCalendar = !_isInCalendar);
        // TODO: اربطيها بمنطق إضافة/إزالة الوجبة من الكالندر فعليًا (API/تخزين)
      },
      onRemoveFromFavorites: () {
        favoritesProvider.toggleFavorite(_asDish);
      },
      onShare: () {
        // TODO: اربطيها بمنطق المشاركة
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.screenPaddingH,
                  8,
                  AppDimens.screenPaddingH,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم الوجبة + مصدرها
                    Text(meal.name, style: AppTextStyles.mealTitle),
                    const SizedBox(height: 2),
                    Text(meal.source, style: AppTextStyles.screenSubtitle),
                    const SizedBox(height: 16),

                    // صورة الوجبة مع الوسوم فوقها
                    _buildMealImage(meal),
                    SizedBox(height: AppDimens.sectionSpacing),

                    // قسم المكونات
                    Text('Ingredients', style: AppTextStyles.sectionHeader),
                    const SizedBox(height: 4),
                    ..._ingredients.asMap().entries.map((entry) {
                      final index = entry.key;
                      final ingredient = entry.value;
                      return IngredientTile(
                        ingredient: ingredient,
                        onChanged: (value) {
                          setState(() {
                            _ingredients[index] =
                                ingredient.copyWith(isChecked: value);
                          });
                        },
                      );
                    }),
                    SizedBox(height: AppDimens.sectionSpacing),

                    // قسم التعليمات
                    Text('Instructions', style: AppTextStyles.sectionHeader),
                    const SizedBox(height: 8),
                    Text(meal.instructions, style: AppTextStyles.bodyText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, AppDimens.screenPaddingTop, 8, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            color: AppColors.textPrimary,
          ),
          const Expanded(
            child: Text(
              'Meal to Prepare',
              textAlign: TextAlign.center,
              style: AppTextStyles.headerTitle,
            ),
          ),
          Builder(
            builder: (btnContext) => IconButton(
              onPressed: () {
                // بناخد مكان الزرار نفسه (⋮) عشان القايمة تفتح جنبه بالظبط
                final renderBox =
                    btnContext.findRenderObject() as RenderBox;
                final globalPosition = renderBox.localToGlobal(
                  renderBox.size.center(Offset.zero),
                );
                _handleMenuTap(globalPosition);
              },
              icon: const Icon(Icons.more_vert, size: 20),
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealImage(Meal meal) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.mealImageRadius),
      child: SizedBox(
        height: AppDimens.mealImageHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: AppColors.searchBackground,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stack) => Container(
                color: AppColors.searchBackground,
                child: const Icon(Icons.broken_image_outlined,
                    color: AppColors.textSecondary),
              ),
            ),
            // وسوم الكويزين ونوع الوجبة أسفل يسار الصورة
            Positioned(
              left: 12,
              bottom: 12,
              child: Row(
                children: [
                  _ImageTagChip(icon: Icons.restaurant, label: meal.cuisineTag),
                  const SizedBox(width: 8),
                  _ImageTagChip(icon: Icons.set_meal, label: meal.mealTypeTag),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageTagChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ImageTagChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.imageOverlay,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textOnImage),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.imageTag),
        ],
      ),
    );
  }
}

