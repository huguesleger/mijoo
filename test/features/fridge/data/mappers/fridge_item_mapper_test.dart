import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/data/mappers/fridge_item_mapper.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

void main() {
  test('writes and reads back an item', () {
    final DateTime date = DateTime(2026, 12, 3);
    final FridgeItem item = firestoreToFridgeItem(
      'lait',
      fridgeItemInputToFirestore(
        FridgeItemInput(
          name: ' Lait ',
          quantity: 1.5,
          unit: FridgeUnit.liter,
          category: FridgeCategory.dairy,
          bestBefore: some(date),
        ),
      ),
    );
    expect(item.id, const FridgeItemId('lait'));
    expect(item.name, 'Lait');
    expect(item.quantity, 1.5);
    expect(item.unit, FridgeUnit.liter);
    expect(item.category, FridgeCategory.dairy);
    expect(item.bestBefore, some(date));
  });

  test('falls back on safe values for unknown data', () {
    final FridgeItem item = firestoreToFridgeItem('x', <String, Object?>{
      'name': 'Pain',
      'quantity': 2,
      'unit': 'tonne',
      'category': 'jardin',
      'bestBefore': null,
    });
    expect(item.quantity, 2);
    expect(item.unit, FridgeUnit.piece);
    expect(item.category, FridgeCategory.other);
    expect(item.bestBefore, const None());
    expect(
      fridgeItemInputToFirestore(
        FridgeItemInput(
          name: 'Pain',
          quantity: 1,
          unit: FridgeUnit.piece,
          category: FridgeCategory.grocery,
          bestBefore: none(),
        ),
      )['bestBefore'],
      isNull,
    );
  });
}
