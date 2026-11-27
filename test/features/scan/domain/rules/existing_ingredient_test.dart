import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/domain/rules/existing_ingredient.dart';

void main() {
  final FridgeItem eggs = FridgeItem(
    id: const FridgeItemId('oeufs'),
    name: 'Œufs',
    quantity: 4,
    unit: FridgeUnit.piece,
    category: FridgeCategory.dairy,
    bestBefore: some(DateTime(2026, 12, 1)),
  );

  FridgeItemInput input(String name, FridgeUnit unit) =>
      FridgeItemInput(name: name, quantity: 6, unit: unit, category: FridgeCategory.other, bestBefore: none());

  test('finds the same ingredient whatever the accents and the case', () {
    expect(existingIngredient(input(' oeufs ', FridgeUnit.piece), <FridgeItem>[eggs]), some(eggs));
  });

  test('keeps apart an ingredient counted in another unit', () {
    expect(existingIngredient(input('Œufs', FridgeUnit.pack), <FridgeItem>[eggs]), isA<None>());
  });

  test('adds the quantity to the existing ingredient and keeps its details', () {
    final FridgeItemInput merged = mergeIntoExisting(eggs, input('oeufs', FridgeUnit.piece));

    expect(merged.name, 'Œufs');
    expect(merged.quantity, 10);
    expect(merged.category, FridgeCategory.dairy);
    expect(merged.bestBefore, some(DateTime(2026, 12, 1)));
  });
}
