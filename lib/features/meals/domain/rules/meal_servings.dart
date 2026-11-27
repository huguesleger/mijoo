import 'dart:math';

import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';

const int minServings = 1;
const int maxServings = 24;

MealIdea mealForServings(MealIdea idea, int servings) => servings == idea.servings
    ? idea
    : idea.copyWith(
        servings: servings,
        ingredients: <MealIngredient>[
          for (final MealIngredient ingredient in idea.ingredients)
            MealIngredient(
              name: ingredient.name,
              quantity: roundedQuantity(ingredient.quantity * servings / idea.servings, ingredient.unit),
              unit: ingredient.unit,
              category: ingredient.category,
              substitute: ingredient.substitute,
            ),
        ],
      );

double roundedQuantity(double quantity, FridgeUnit unit) => switch (unit) {
  FridgeUnit.piece || FridgeUnit.pack => max(0.5, (quantity * 2).round() / 2),
  FridgeUnit.gram || FridgeUnit.milliliter =>
    quantity >= 50 ? max(5, (quantity / 5).round() * 5).toDouble() : max(1, quantity.round()).toDouble(),
  FridgeUnit.kilogram || FridgeUnit.liter => max(0.01, (quantity * 100).round() / 100),
};
