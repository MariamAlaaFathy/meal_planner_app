class Ingredient {
  final String name;
  final String quantity;
  final bool isChecked;

  const Ingredient({
    required this.name,
    required this.quantity,
    this.isChecked = false,
  });

  Ingredient copyWith({bool? isChecked}) {
    return Ingredient(
      name: name,
      quantity: quantity,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final String source; // مثال: "From your calendar"
  final String cuisineTag; // مثال: "Japanese"
  final String mealTypeTag; // مثال: "Chicken"
  final List<Ingredient> ingredients;
  final String instructions;

  const Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.source,
    required this.cuisineTag,
    required this.mealTypeTag,
    required this.ingredients,
    required this.instructions,
  });
}

/// بيانات وهمية (static) مطابقة للسكرين — استبدليها بالبيانات الحقيقية لما تجيبيها من السيرفر.
final Meal dummyMeal = Meal(
  id: '1',
  name: 'Spicy Arrabiata Penne',
  imageUrl: 'https://images.unsplash.com/photo-1608219992759-8d74ed8d76eb?w=800',
  source: 'From your calendar',
  cuisineTag: 'Japanese',
  mealTypeTag: 'Chicken',
  ingredients: const [
    Ingredient(name: 'penne rigate', quantity: '1 pound', isChecked: true),
    Ingredient(name: 'olive oil', quantity: '1/4 cup', isChecked: true),
    Ingredient(name: 'garlic', quantity: '3 cloves', isChecked: true),
    Ingredient(name: 'chopped tomatoes', quantity: '1 tin', isChecked: true),
    Ingredient(name: 'red chilli flakes', quantity: '1/2 teaspoon'),
  ],
  instructions:
      'Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\n\n'
      'Combine soy sauce, ¼ cup water, brown sugar, ginger and garlic in a small saucepan '
      'and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once '
      'boiling.\n\n'
      'Meanwhile, stir together the corn starch and 2 tablespoons of water in a separate '
      'dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to '
      'combine. Cook until the sauce starts to thicken then remove from heat.',
);
