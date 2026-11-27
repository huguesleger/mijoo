import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/shopping/domain/entities/basket_estimate.dart';

final class WeekBudget {
  const WeekBudget({
    required this.start,
    required this.budgetCents,
    required this.spentCents,
    required this.basket,
  });

  final DateTime start;
  final Option<int> budgetCents;
  final int spentCents;
  final BasketEstimate basket;

  Option<double> get remainingCents => budgetCents.map((int budget) => budget - spentCents - basket.cents);
}
