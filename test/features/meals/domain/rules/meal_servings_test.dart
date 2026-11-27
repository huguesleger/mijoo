import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/rules/meal_servings.dart';

import '../../meals_fixtures.dart';

void main() {
  test('scales every quantity to the chosen number of people', () {
    final meal = mealForServings(mealIdea(), 6);
    expect(meal.servings, 6);
    expect(meal.ingredients.map((it) => it.quantity), [1.5, 6, 150]);
  });

  test('keeps the recipe as it is for its own number of people', () {
    final idea = mealIdea();
    expect(identical(mealForServings(idea, 4), idea), isTrue);
  });

  test('rounds to amounts a parent can measure', () {
    expect(roundedQuantity(4 * 3 / 4, FridgeUnit.piece), 3);
    expect(roundedQuantity(1 / 4, FridgeUnit.piece), 0.5);
    expect(roundedQuantity(233.3, FridgeUnit.gram), 235);
    expect(roundedQuantity(12.4, FridgeUnit.milliliter), 12);
    expect(roundedQuantity(0.333, FridgeUnit.kilogram), 0.33);
  });
}
