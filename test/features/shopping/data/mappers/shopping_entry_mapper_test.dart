import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/data/mappers/shopping_entry_mapper.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';

void main() {
  test('stores and reads back an entry of the list', () {
    final input = ShoppingEntryInput(
      key: 'pain',
      name: ' Pain ',
      quantity: some(2),
      unit: FridgeUnit.piece,
      category: some(FridgeCategory.grocery),
      checked: true,
      dismissed: false,
      manual: true,
      addedBy: some('Camille'),
    );
    final read = firestoreToShoppingEntry('m1', shoppingEntryToFirestore(input)).map((it) => it.input);
    expect(read.map((it) => it.name), some('Pain'));
    expect(read.flatMap((it) => it.quantity), some(2.0));
    expect(read.flatMap((it) => it.category), some(FridgeCategory.grocery));
    expect(read.map((it) => it.checked && it.manual), some(true));
    expect(read.flatMap((it) => it.addedBy), some('Camille'));
  });

  test('ignores an entry without name and repairs odd values', () {
    expect(firestoreToShoppingEntry('x', {'name': ''}), isA<None>());
    final read = firestoreToShoppingEntry('x', {'name': 'Lait', 'quantity': -1, 'unit': 'tonne', 'category': 'jardin'});
    expect(read.flatMap((it) => it.input.quantity), isA<None>());
    expect(read.map((it) => it.input.unit), some(FridgeUnit.piece));
    expect(read.flatMap((it) => it.input.category), isA<None>());
  });
}
