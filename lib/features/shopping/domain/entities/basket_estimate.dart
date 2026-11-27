import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';

final class BasketEstimate {
  const BasketEstimate({
    required this.cents,
    required this.lowCents,
    required this.highCents,
    required this.costs,
    required this.unpriced,
  });

  final double cents;
  final double lowCents;
  final double highCents;
  final Map<ShoppingEntryId, LineCost> costs;
  final Set<ShoppingEntryId> unpriced;
}
