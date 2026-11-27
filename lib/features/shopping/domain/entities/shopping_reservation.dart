import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';

final class ShoppingReservation {
  const ShoppingReservation({required this.item, required this.quantity, required this.meals});

  final FridgeItem item;
  final double quantity;
  final List<String> meals;
}
