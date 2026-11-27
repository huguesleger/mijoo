import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';

import '../../../meals/meals_fixtures.dart';
import '../../shopping_fixtures.dart';

void main() {
  final omelette = weekMeal('Omelette', [ingredient('Œufs', quantity: 4)]);
  final salad = weekMeal('Salade de pâtes', [
    ingredient('Oeufs', quantity: 3),
    ingredient('Carottes', quantity: 300, unit: FridgeUnit.gram),
  ], order: 1);
  final soup = weekMeal('Velouté', [ingredient('Carottes', quantity: 0.5, unit: FridgeUnit.kilogram)], order: 2);

  ShoppingLine line(List<ShoppingLine> lines, String key) => lines.firstWhere((it) => it.key == key);

  test('sums the needs of the week and removes what the fridge holds once', () {
    final list = shoppingList((week: [omelette, salad], items: [fridgeItem('Oeufs', quantity: 6)], entries: []));
    final eggs = line(list.lines, 'oeuf');
    expect(eggs.needed, some(1.0));
    expect(eggs.meals, ['Salade de pâtes']);
    expect(eggs.pack, some(ShoppingPack.eggBox));
    expect(eggs.purchase, 6);
    expect(list.reservations.single.quantity, 6);
    expect(list.reservations.single.meals, ['Omelette', 'Salade de pâtes']);
    expect(list.plannedMeals, 2);
  });

  test('merges grams and kilograms into one line', () {
    final list = shoppingList((week: [salad, soup], items: [], entries: []));
    final carrots = line(list.lines, 'carotte');
    expect(carrots.needed, some(800.0));
    expect(carrots.unit, FridgeUnit.gram);
    expect(carrots.meals, ['Salade de pâtes', 'Velouté']);
  });

  test('leaves cooked meals out of the list', () {
    final cooked = weekMeal('Omelette', [ingredient('Œufs', quantity: 4)], status: WeekMealStatus.cooked);
    final list = shoppingList((week: [cooked], items: [], entries: []));
    expect(list.lines, isEmpty);
    expect(list.plannedMeals, 0);
  });

  test('applies what the household did on the list', () {
    final eggsId = needEntryId('oeuf', FridgeUnit.piece);
    final carrotsId = needEntryId('carotte', FridgeUnit.gram);
    final list = shoppingList((
      week: [salad],
      items: [],
      entries: [
        entry(eggsId.value, key: 'oeuf', checked: true, quantity: some(12)),
        entry(carrotsId.value, key: 'carotte', dismissed: true),
        entry('m1', key: 'pain', name: 'Pain', quantity: some(2), manual: true),
      ],
    ));
    expect(line(list.lines, 'oeuf').checked, isTrue);
    expect(line(list.lines, 'oeuf').purchase, 12);
    expect(list.lines.where((it) => it.key == 'carotte'), isEmpty);
    expect(line(list.lines, 'pain').manual, isTrue);
    expect(line(list.lines, 'pain').addedBy, some('Camille'));
  });

  test('records the household choices on a line', () {
    final eggs = line(shoppingList((week: [salad], items: [], entries: [])).lines, 'oeuf');
    final saved = lineEntry(eggs, checked: true, quantity: 12);
    expect(saved.checked, isTrue);
    expect(saved.quantity, some(12.0));
    expect(saved.manual, isFalse);
    expect(lineEntry(eggs, dismissed: true).dismissed, isTrue);
  });
}
