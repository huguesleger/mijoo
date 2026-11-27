import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/meals/domain/entities/ingredient_availability.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';
import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/price_book.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';

typedef MealCost = ({double cents, int unpriced});

MealCost mealCost(MealIdea idea, List<FridgeItem> items, PriceBook book) => idea.ingredients.fold(
  (cents: 0, unpriced: 0),
  (MealCost total, MealIngredient ingredient) => switch (ingredientAvailability(ingredient, items)) {
    InFridge() => total,
    NotEnoughInFridge(:final double missing) => _add(total, ingredient, missing, book),
    ToBuy() => _add(total, ingredient, ingredient.quantity, book),
  },
);

MealCost _add(MealCost total, MealIngredient ingredient, double quantity, PriceBook book) =>
    costOf(ingredient.name, quantity, ingredient.unit, book).match(
      () => (cents: total.cents, unpriced: total.unpriced + 1),
      (LineCost cost) => (cents: total.cents + cost.cents, unpriced: total.unpriced),
    );
