import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

Option<double> convertQuantity(double quantity, FridgeUnit from, FridgeUnit to) => switch ((from, to)) {
  _ when from == to => some(quantity),
  (FridgeUnit.gram, FridgeUnit.kilogram) || (FridgeUnit.milliliter, FridgeUnit.liter) => some(quantity / 1000),
  (FridgeUnit.kilogram, FridgeUnit.gram) || (FridgeUnit.liter, FridgeUnit.milliliter) => some(quantity * 1000),
  _ => none(),
};
