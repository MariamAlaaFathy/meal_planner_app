import 'package:flutter/material.dart';
import 'package:meal_planner_app/widgets/BottomBar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create:(_)=>FavoritesProvider(),
      child: const MealPlannerApp(),
    ),
  );
}

class MealPlannerApp extends StatelessWidget {
  const MealPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SplashScreen(),
    );
  }
}
