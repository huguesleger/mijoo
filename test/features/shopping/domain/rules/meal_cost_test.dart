import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/domain/rules/meal_cost.dart';

import '../../../meals/meals_fixtures.dart';

void main() {
  test('costs only what the fridge does not hold', () {
    final idea = mealIdea(
      ingredients: [
        ingredient('Œufs', quantity: 6),
        ingredient('Carottes', quantity: 500, unit: FridgeUnit.gram),
        ingredient('Épices rares', quantity: 1),
      ],
    );
    final cost = mealCost(idea, [fridgeItem('Oeufs', quantity: 4)], (household: [], openPrices: {}));
    expect(cost.cents, closeTo(2 * 30 + 0.5 * 150, 0.001));
    expect(cost.unpriced, 1);
  });

  test('costs nothing when everything is in the fridge', () {
    final idea = mealIdea(ingredients: [ingredient('Œufs', quantity: 2)]);
    expect(mealCost(idea, [fridgeItem('Oeufs', quantity: 6)], (household: [], openPrices: {})), (
      cents: 0,
      unpriced: 0,
    ));
  });
}
