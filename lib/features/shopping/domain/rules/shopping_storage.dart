import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_units.dart';

typedef ShoppingStorage = ({ShoppingLine line, double quantity});

FridgeItemInput storageToFridgeItem(ShoppingStorage storage) {
  final BaseQuantity readable = toReadableUnit(storage.quantity, storage.line.unit);
  return FridgeItemInput(
    name: storage.line.name,
    quantity: readable.quantity,
    unit: readable.unit,
    category: storage.line.category,
    bestBefore: none(),
  );
}
