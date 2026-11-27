import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/domain/rules/meal_deductions.dart';
import 'package:mijoo/features/meals/domain/rules/meal_units.dart';

import '../../meals_fixtures.dart';

void main() {
  test('proposes the quantity of the recipe, within the stock', () {
    final eggs = fridgeItem('Oeufs', quantity: 6);
    final cheese = fridgeItem('Gruyère râpé', quantity: 0.25, unit: FridgeUnit.kilogram);
    final spinach = fridgeItem('Épinards', quantity: 300, unit: FridgeUnit.gram);
    final deductions = proposedDeductions(mealIdea(), [eggs, cheese, spinach]);
    expect(
      {for (final MealDeduction deduction in deductions) deduction.item.name: deduction.quantity},
      {'Épinards': 300, 'Oeufs': 4, 'Gruyère râpé': 0.1},
    );
  });

  test('never proposes more than the stock', () {
    final deductions = proposedDeductions(mealIdea(), [fridgeItem('Oeufs', quantity: 2)]);
    expect(deductions.single.quantity, 2);
  });

  test('converts grams and kilograms, not pieces and grams', () {
    expect(convertQuantity(500, FridgeUnit.gram, FridgeUnit.kilogram), some(0.5));
    expect(convertQuantity(1.5, FridgeUnit.liter, FridgeUnit.milliliter), some(1500.0));
    expect(convertQuantity(2, FridgeUnit.piece, FridgeUnit.gram), isA<None>());
  });

  test('keeps what is left, or removes the item once used up', () {
    final eggs = fridgeItem('Oeufs', quantity: 6);
    expect(remainingAfter(MealDeduction(item: eggs, quantity: 4)).map((it) => it.quantity), some(2.0));
    expect(remainingAfter(MealDeduction(item: eggs, quantity: 6)), isA<None>());
  });
}
