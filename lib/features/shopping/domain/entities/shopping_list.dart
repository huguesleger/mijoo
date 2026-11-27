import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_reservation.dart';

final class ShoppingList {
  const ShoppingList({required this.lines, required this.reservations, required this.plannedMeals});

  final List<ShoppingLine> lines;
  final List<ShoppingReservation> reservations;
  final int plannedMeals;
}
