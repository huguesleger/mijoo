import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

final class MealIngredient {
  const MealIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.substitute,
  });

  final String name;
  final double quantity;
  final FridgeUnit unit;
  final FridgeCategory category;
  final Option<String> substitute;
}
