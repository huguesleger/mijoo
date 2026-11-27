import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';

final class MealDeduction {
  const MealDeduction({required this.item, required this.quantity});

  final FridgeItem item;
  final double quantity;
}
