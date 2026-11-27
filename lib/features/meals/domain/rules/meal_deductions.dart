import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';
import 'package:mijoo/features/meals/domain/rules/meal_units.dart';

List<MealDeduction> proposedDeductions(MealIdea idea, List<FridgeItem> items) {
  final Map<FridgeItemId, MealDeduction> deductions = <FridgeItemId, MealDeduction>{};
  for (final MealIngredient ingredient in idea.ingredients) {
    stockFor(ingredient, items).match(() => null, (FridgeItem item) {
      final double needed = convertQuantity(ingredient.quantity, ingredient.unit, item.unit).getOrElse(
        () => item.quantity,
      );
      final double already = deductions[item.id]?.quantity ?? 0;
      deductions[item.id] = MealDeduction(item: item, quantity: min(item.quantity, already + needed));
    });
  }
  return deductions.values.toList();
}

Option<FridgeItemInput> remainingAfter(MealDeduction deduction) {
  final double left = deduction.item.quantity - deduction.quantity;
  return left > 0.0001
      ? some(
          FridgeItemInput(
            name: deduction.item.name,
            quantity: double.parse(left.toStringAsFixed(3)),
            unit: deduction.item.unit,
            category: deduction.item.category,
            bestBefore: deduction.item.bestBefore,
          ),
        )
      : none();
}
