import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_packs.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_units.dart';

String readableQuantity(double quantity, FridgeUnit unit) {
  final BaseQuantity readable = toReadableUnit(quantity, unit);
  return fridgeQuantityLabel(readable.quantity, readable.unit);
}

String packLabel(ShoppingPack pack) => t.shopping.packs[pack.name] ?? pack.name;

String shoppingQuantityLabel(ShoppingLine line, double quantity) => line.pack.match(
  () => readableQuantity(quantity, line.unit),
  (ShoppingPack pack) => t.shopping.packed(count: (quantity / packSize(pack).size).round(), pack: packLabel(pack)),
);

Option<String> shoppingNeededLabel(ShoppingLine line) => line.needed
    .filter((double needed) => (needed - line.purchase).abs() > 0.0001)
    .map((double needed) => t.shopping.needed(quantity: readableQuantity(needed, line.unit)));
