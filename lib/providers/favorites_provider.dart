import 'package:flutter/foundation.dart';
import '../models/dish.dart';

/// Single source of truth for the user's favorite dishes.
///
/// Screens are responsible for deciding when to call add/remove/toggle.
/// This provider only owns the favorites state and notifies listeners
/// immediately whenever that state changes.
class FavoritesProvider extends ChangeNotifier {
  final List<Dish> _favorites = <Dish>[];

  List<Dish> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String dishId) {
    return _favorites.any((dish) => dish.id == dishId);
  }

  void addFavorite(Dish dish) {
    if (isFavorite(dish.id)) return;

    _favorites.add(dish);
    notifyListeners();
  }

  void removeFavorite(String dishId) {
    final oldLength = _favorites.length;
    _favorites.removeWhere((dish) => dish.id == dishId);

    if (_favorites.length != oldLength) {
      notifyListeners();
    }
  }

  void toggleFavorite(Dish dish) {
    if (isFavorite(dish.id)) {
      removeFavorite(dish.id);
    } else {
      addFavorite(dish);
    }
  }

  void clearFavorites() {
    if (_favorites.isEmpty) return;

    _favorites.clear();
    notifyListeners();
  }
}
