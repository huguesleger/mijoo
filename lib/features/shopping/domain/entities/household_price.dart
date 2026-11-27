import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

final class HouseholdPrice {
  const HouseholdPrice({required this.key, required this.name, required this.cents, required this.basis});

  final String key;
  final String name;
  final double cents;
  final PriceBasis basis;
}
