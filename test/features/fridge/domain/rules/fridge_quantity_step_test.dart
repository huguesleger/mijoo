import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity_step.dart';

void main() {
  test('steps by a natural amount for each unit', () {
    expect(increaseFridgeQuantity(4, FridgeUnit.piece), 5);
    expect(increaseFridgeQuantity(500, FridgeUnit.gram), 550);
    expect(increaseFridgeQuantity(1, FridgeUnit.liter), 1.5);
  });

  test('never goes below one step', () {
    expect(decreaseFridgeQuantity(1, FridgeUnit.piece), 1);
    expect(decreaseFridgeQuantity(0.7, FridgeUnit.kilogram), 0.5);
  });
}
