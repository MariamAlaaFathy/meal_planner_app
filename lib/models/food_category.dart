class FoodCategory {
  final String id;
  final String name;

  const FoodCategory({required this.id, required this.name});
}

const List<FoodCategory> dummyCategories = [
  FoodCategory(id: 'breakfast', name: 'Breakfast'),
  FoodCategory(id: 'starter', name: 'Starter'),
  FoodCategory(id: 'dessert', name: 'Dessert'),
  FoodCategory(id: 'lunch', name: 'Lunch'),
  FoodCategory(id: 'side', name: 'Side'),
  FoodCategory(id: 'vegan', name: 'Vegan'),
  FoodCategory(id: 'vegetarian', name: 'Vegetarian'),
  FoodCategory(id: 'pasta', name: 'Pasta'),
  FoodCategory(id: 'seafood', name: 'Seafood'),
  FoodCategory(id: 'miscellaneous', name: 'Miscellaneous'),
];
