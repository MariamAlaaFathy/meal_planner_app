class FoodCategory {
  final String id;
  final String name;

  const FoodCategory({required this.id, required this.name, required String imageUrl});
}

const List<FoodCategory> dummyCategories = [
  FoodCategory(id: 'breakfast', name: 'Breakfast', imageUrl: ''),
  FoodCategory(id: 'starter', name: 'Starter', imageUrl: ''),
  FoodCategory(id: 'dessert', name: 'Dessert', imageUrl: ''),
  FoodCategory(id: 'lunch', name: 'Lunch', imageUrl: ''),
  FoodCategory(id: 'side', name: 'Side', imageUrl: ''),
  FoodCategory(id: 'vegan', name: 'Vegan', imageUrl: ''),
  FoodCategory(id: 'vegetarian', name: 'Vegetarian', imageUrl: ''),
  FoodCategory(id: 'pasta', name: 'Pasta', imageUrl: ''),
  FoodCategory(id: 'seafood', name: 'Seafood', imageUrl: ''),
  FoodCategory(id: 'miscellaneous', name: 'Miscellaneous', imageUrl: ''),
];
