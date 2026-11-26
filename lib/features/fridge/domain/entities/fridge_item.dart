import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

extension type const FridgeItemId(String value) {}

final class FridgeItem {
  const FridgeItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.bestBefore,
  });

  final FridgeItemId id;
  final String name;
  final double quantity;
  final FridgeUnit unit;
  final FridgeCategory category;
  final Option<DateTime> bestBefore;
}
