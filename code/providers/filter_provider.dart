import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNOtifier extends StateNotifier<Map<Filter, bool>> {
  FilterNOtifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;//is not allowed
    state = {
      ...state, //sperad the all keys
      filter: isActive,
    };
  }

  void SetFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filterProvider =
    StateNotifierProvider<FilterNOtifier, Map<Filter, bool>>((ref) {
  return FilterNOtifier();
});

final filteredMealsprovider = Provider((ref) {
  final meals = ref.watch(meals_provider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
