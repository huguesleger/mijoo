import 'package:intl/intl.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

String fridgeQuantityLabel(FridgeItem item) {
  final String count = NumberFormat.decimalPattern('fr').format(item.quantity);
  final bool single = item.quantity <= 1;
  return switch (item.unit) {
    FridgeUnit.piece =>
      single ? t.fridge.quantities.pieceSingle(count: count) : t.fridge.quantities.pieceSeveral(count: count),
    FridgeUnit.pack =>
      single ? t.fridge.quantities.packSingle(count: count) : t.fridge.quantities.packSeveral(count: count),
    FridgeUnit.gram => t.fridge.quantities.gram(count: count),
    FridgeUnit.kilogram => t.fridge.quantities.kilogram(count: count),
    FridgeUnit.milliliter => t.fridge.quantities.milliliter(count: count),
    FridgeUnit.liter => t.fridge.quantities.liter(count: count),
  };
}
