import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/price_source.dart';

final class ReferencePrice {
  const ReferencePrice({
    required this.cents,
    required this.lowCents,
    required this.highCents,
    required this.basis,
    required this.source,
    required this.observations,
    required this.lastSeen,
  });

  final double cents;
  final double lowCents;
  final double highCents;
  final PriceBasis basis;
  final PriceSource source;
  final int observations;
  final Option<DateTime> lastSeen;
}
