import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_packs.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_units.dart';

void main() {
  test('finds the usual packaging of an ingredient', () {
    expect(packFor('Œufs', FridgeUnit.piece), some(ShoppingPack.eggBox));
    expect(packFor('Gruyère râpé', FridgeUnit.gram), some(ShoppingPack.gratedCheese));
    expect(packFor('Beurre doux', FridgeUnit.gram), some(ShoppingPack.butter));
    expect(packFor('Beurre doux', FridgeUnit.piece), isA<None>());
    expect(packFor('Carottes', FridgeUnit.gram), isA<None>());
  });

  test('rounds up to whole packs', () {
    expect(packedQuantity(5, some(ShoppingPack.eggBox)), 6);
    expect(packedQuantity(7, some(ShoppingPack.eggBox)), 12);
    expect(packedQuantity(6, some(ShoppingPack.eggBox)), 6);
    expect(packedQuantity(90, some(ShoppingPack.gratedCheese)), 200);
    expect(packedQuantity(90, none()), 90);
  });

  test('reads large amounts in kilograms and litres', () {
    expect(toBaseUnit(1.5, FridgeUnit.kilogram), (quantity: 1500.0, unit: FridgeUnit.gram));
    expect(toReadableUnit(1500, FridgeUnit.milliliter), (quantity: 1.5, unit: FridgeUnit.liter));
    expect(toReadableUnit(800, FridgeUnit.gram), (quantity: 800.0, unit: FridgeUnit.gram));
  });
}
