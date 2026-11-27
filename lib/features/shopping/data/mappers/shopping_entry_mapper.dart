import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';

typedef ShoppingEntryData = Map<String, Object?>;

const int maxShoppingNameLength = 80;

Option<ShoppingEntry> firestoreToShoppingEntry(String id, ShoppingEntryData data) => switch (data['name']) {
  final String name when name.trim().isNotEmpty => some(
    ShoppingEntry(
      id: ShoppingEntryId(id),
      input: ShoppingEntryInput(
        key: switch (data['key']) {
          final String key => key,
          _ => '',
        },
        name: name.trim(),
        quantity: switch (data['quantity']) {
          final num quantity when quantity > 0 && quantity <= maxFridgeQuantity => some(quantity.toDouble()),
          _ => none(),
        },
        unit: _byName(FridgeUnit.values, data['unit']).getOrElse(() => FridgeUnit.piece),
        category: _byName(FridgeCategory.values, data['category']),
        checked: data['checked'] == true,
        dismissed: data['dismissed'] == true,
        manual: data['manual'] == true,
        addedBy: switch (data['addedBy']) {
          final String name when name.isNotEmpty => some(name),
          _ => none(),
        },
      ),
    ),
  ),
  _ => none(),
};

ShoppingEntryData shoppingEntryToFirestore(ShoppingEntryInput input) => <String, Object?>{
  'key': input.key,
  'name': input.name.trim(),
  'quantity': input.quantity.toNullable(),
  'unit': input.unit.name,
  'category': input.category.map((FridgeCategory category) => category.name).toNullable(),
  'checked': input.checked,
  'dismissed': input.dismissed,
  'manual': input.manual,
  'addedBy': input.addedBy.toNullable(),
};

Option<T> _byName<T extends Enum>(List<T> values, Object? name) =>
    Option<T>.fromNullable(values.where((T value) => value.name == name).firstOrNull);
