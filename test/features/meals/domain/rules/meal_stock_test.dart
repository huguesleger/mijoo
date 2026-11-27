import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/ingredient_availability.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';

import '../../meals_fixtures.dart';

void main() {
  test('recognizes a fridge item under a close name', () {
    expect(sameIngredient('Œufs', 'Oeufs frais'), isTrue);
    expect(sameIngredient('Crème fraîche', 'crème fraiche épaisse'), isTrue);
    expect(sameIngredient('Tomates', 'Tomate'), isTrue);
    expect(sameIngredient('Lait', 'Laitue'), isFalse);
    expect(sameIngredient('Huile d’olive', 'Olives noires'), isFalse);
  });

  test('counts what the fridge already covers', () {
    final coverage = mealCoverage(mealIdea(), [
      fridgeItem('Épinards', unit: FridgeUnit.pack),
      fridgeItem('Oeufs', quantity: 6),
    ]);
    expect(coverage, (inFridge: 2, total: 3));
    expect(missingIngredients(mealIdea(), [fridgeItem('Épinards')]).map((it) => it.name), [
      'Œufs',
      'Gruyère râpé',
    ]);
  });

  test('uses the item to finish first among several matches', () {
    final soon = fridgeItem('Oeufs bio', bestBefore: some(today.add(const Duration(days: 1))));
    final later = fridgeItem('Oeufs', bestBefore: some(today.add(const Duration(days: 10))));
    expect(stockFor(ingredient('Œufs'), [later, soon]), some(soon));
  });

  test('lists the items to finish first that the meal uses', () {
    final spinach = fridgeItem('Épinards', bestBefore: some(today.add(const Duration(days: 1))));
    final expired = fridgeItem('Oeufs', bestBefore: some(today.subtract(const Duration(days: 2))));
    final carrots = fridgeItem('Carottes', bestBefore: some(today));
    expect(finishFirstUsed(mealIdea(), [spinach, expired, carrots], today), [spinach]);
  });

  test('tells whether the fridge holds enough of each ingredient', () {
    final items = [
      fridgeItem('Oeufs', quantity: 6),
      fridgeItem('Gruyère râpé', quantity: 0.05, unit: FridgeUnit.kilogram),
    ];
    expect(ingredientAvailability(ingredient('Œufs', quantity: 4), items), isA<InFridge>());
    expect(
      ingredientAvailability(ingredient('Œufs', quantity: 9), items),
      isA<NotEnoughInFridge>().having((it) => it.missing, 'missing', 3),
    );
    expect(
      ingredientAvailability(ingredient('Gruyère râpé', quantity: 90, unit: FridgeUnit.gram), items),
      isA<NotEnoughInFridge>().having((it) => it.missing, 'missing', closeTo(40, 0.001)),
    );
    expect(
      ingredientAvailability(ingredient('Épinards', unit: FridgeUnit.pack), [
        fridgeItem('Épinards', quantity: 300, unit: FridgeUnit.gram),
      ]),
      isA<InFridge>(),
    );
    expect(ingredientAvailability(ingredient('Lait'), items), isA<ToBuy>());
  });
}
