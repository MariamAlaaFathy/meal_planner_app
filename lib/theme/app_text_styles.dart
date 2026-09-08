import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ⚠️ اسم الفونت "Poppins" ده افتراضي — غيّريه لاسم الفونت الحقيقي من فيجما.
/// لو الفونت مش من Google Fonts الافتراضية في فلاتر، لازم:
/// 1. تضيفي حزمة google_fonts في pubspec.yaml، أو
/// 2. تحملي ملفات الفونت (.ttf) في assets/fonts وتسجليها في pubspec.yaml
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Poppins'; // غيّريه حسب الفونت في فيجما

  // عنوان الشاشة الكبير مثل "Explore Tab" أو "Breakfast"
  static const TextStyle screenTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // العنوان الفرعي الرمادي تحت العنوان الكبير مثل "Category"
  static const TextStyle screenSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // نص التابس "Categories" / "Cuisines"
  static const TextStyle tabLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  // نص الـ Search hint
  static const TextStyle searchHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // اسم الكاتيجوري في الليست مثل "Breakfast", "Starter"
  static const TextStyle categoryItem = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // اسم الطبق فوق الصورة مثل "Spicy Arrabiata Penne"
  static const TextStyle dishTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnImage,
  );

  // نص زرار "More"
  static const TextStyle moreButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnImage,
  );

  // نص عناصر الـ bottom nav
  static const TextStyle navLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  // اسم الوجبة الكبير في شاشة Meal to Prepare مثل "Spicy Arrabiata Penne"
  static const TextStyle mealTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // عناوين الأقسام مثل "Ingredients", "Instructions", "Recipe Video"
  static const TextStyle sectionHeader = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // نص الفقرات الطويلة (تعليمات الوصفة)
  static const TextStyle bodyText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // نص الوسم الصغير فوق الصورة مثل "Japanese", "Chicken"
  static const TextStyle imageTag = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnImage,
  );

  // عنوان شريط الهيدر في المنتصف مثل "Meal to Prepare"
  static const TextStyle headerTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
}
