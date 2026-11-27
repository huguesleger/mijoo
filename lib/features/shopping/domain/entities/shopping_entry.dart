import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

extension type const ShoppingEntryId(String value) {}

final class ShoppingEntryInput {
  const ShoppingEntryInput({
    required this.key,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.checked,
    required this.dismissed,
    required this.manual,
    required this.addedBy,
  });

  final String key;
  final String name;
  final Option<double> quantity;
  final FridgeUnit unit;
  final Option<FridgeCategory> category;
  final bool checked;
  final bool dismissed;
  final bool manual;
  final Option<String> addedBy;
}

final class ShoppingEntry {
  const ShoppingEntry({required this.id, required this.input});

  final ShoppingEntryId id;
  final ShoppingEntryInput input;
}
