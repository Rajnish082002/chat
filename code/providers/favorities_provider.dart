import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals_riverpod/models/meal.dart";

class FavoritiesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritiesMealsNotifier() : super([]);

  bool toggleMealFavoritierStatus(Meal meal) {
    final mealIsFavorities = state.contains(meal);
    if (mealIsFavorities) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritiesMealsNotifier, List<Meal>>((ref) {
  return FavoritiesMealsNotifier();
});
