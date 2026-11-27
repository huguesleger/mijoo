import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

final class OpenPriceStats {
  const OpenPriceStats({
    required this.tag,
    required this.basis,
    required this.cents,
    required this.lowCents,
    required this.highCents,
    required this.observations,
    required this.lastSeen,
  });

  final String tag;
  final PriceBasis basis;
  final double cents;
  final double lowCents;
  final double highCents;
  final int observations;
  final DateTime lastSeen;
}
