import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';

final class ShoppingLine {
  const ShoppingLine({
    required this.id,
    required this.key,
    required this.name,
    required this.needed,
    required this.purchase,
    required this.unit,
    required this.pack,
    required this.category,
    required this.meals,
    required this.checked,
    required this.manual,
    required this.addedBy,
  });

  final ShoppingEntryId id;
  final String key;
  final String name;
  final Option<double> needed;
  final double purchase;
  final FridgeUnit unit;
  final Option<ShoppingPack> pack;
  final FridgeCategory category;
  final List<String> meals;
  final bool checked;
  final bool manual;
  final Option<String> addedBy;
}
