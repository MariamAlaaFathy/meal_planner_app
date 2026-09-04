class Dish {
  final String id;
  final String name;
  final String imageUrl;

  const Dish({required this.id, required this.name, required this.imageUrl});
}

const List<Dish> dummyDishes = [
  Dish(
    id: '1',
    name: 'Spicy Arrabiata Penne',
    imageUrl: 'assets/images/george-zheng-0Kbjfwunink-unsplash1(1).png',
  ),
  Dish(
    id: '2',
    name: 'Loaded Baked Potatoes',
    imageUrl: 'assets/images/george-zheng-0Kbjfwunink-unsplash1.png',
  ),
];
