import 'package:mijoo/features/shopping/domain/entities/reference_price.dart';

final class LineCost {
  const LineCost({required this.price, required this.cents, required this.lowCents, required this.highCents});

  final ReferencePrice price;
  final double cents;
  final double lowCents;
  final double highCents;
}
