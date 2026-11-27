import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

typedef BaseQuantity = ({double quantity, FridgeUnit unit});

BaseQuantity toBaseUnit(double quantity, FridgeUnit unit) => switch (unit) {
  FridgeUnit.kilogram => (quantity: quantity * 1000, unit: FridgeUnit.gram),
  FridgeUnit.liter => (quantity: quantity * 1000, unit: FridgeUnit.milliliter),
  FridgeUnit.gram || FridgeUnit.milliliter || FridgeUnit.piece || FridgeUnit.pack => (quantity: quantity, unit: unit),
};

BaseQuantity toReadableUnit(double quantity, FridgeUnit unit) => switch (unit) {
  FridgeUnit.gram when quantity >= 1000 => (quantity: quantity / 1000, unit: FridgeUnit.kilogram),
  FridgeUnit.milliliter when quantity >= 1000 => (quantity: quantity / 1000, unit: FridgeUnit.liter),
  _ => (quantity: quantity, unit: unit),
};
