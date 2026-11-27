import 'dart:math';

import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';

double fridgeQuantityStep(FridgeUnit unit) => switch (unit) {
  FridgeUnit.piece || FridgeUnit.pack => 1,
  FridgeUnit.gram || FridgeUnit.milliliter => 50,
  FridgeUnit.kilogram || FridgeUnit.liter => 0.5,
};

double increaseFridgeQuantity(double quantity, FridgeUnit unit) =>
    min(quantity + fridgeQuantityStep(unit), maxFridgeQuantity);

double decreaseFridgeQuantity(double quantity, FridgeUnit unit) =>
    max(quantity - fridgeQuantityStep(unit), fridgeQuantityStep(unit));
