import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

typedef FridgeItemData = Map<String, Object?>;

FridgeItem firestoreToFridgeItem(String id, FridgeItemData data) => FridgeItem(
  id: FridgeItemId(id),
  name: switch (data['name']) {
    final String name => name,
    _ => '',
  },
  quantity: switch (data['quantity']) {
    final num quantity => quantity.toDouble(),
    _ => 1,
  },
  unit: _byName(FridgeUnit.values, data['unit']).getOrElse(() => FridgeUnit.piece),
  category: _byName(FridgeCategory.values, data['category']).getOrElse(() => FridgeCategory.other),
  bestBefore: switch (data['bestBefore']) {
    final Timestamp timestamp => some(timestamp.toDate()),
    _ => none(),
  },
);

FridgeItemData fridgeItemInputToFirestore(FridgeItemInput input) => <String, Object?>{
  'name': input.name.trim(),
  'quantity': input.quantity,
  'unit': input.unit.name,
  'category': input.category.name,
  'bestBefore': input.bestBefore.map(Timestamp.fromDate).toNullable(),
};

Option<T> _byName<T extends Enum>(List<T> values, Object? name) =>
    Option<T>.fromNullable(values.where((T value) => value.name == name).firstOrNull);
