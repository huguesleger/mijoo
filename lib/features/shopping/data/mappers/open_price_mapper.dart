import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

const double lowPercentile = 0.1;
const double highPercentile = 0.9;

Option<OpenPriceStats> openPricesToStats(String tag, PriceBasis basis, String body) {
  final String per = switch (basis) {
    PriceBasis.kilogram || PriceBasis.liter => 'KILOGRAM',
    PriceBasis.piece => 'UNIT',
  };
  final List<({double cents, DateTime date})> prices = switch (Option<Object?>.tryCatch(() => jsonDecode(body))) {
    Some(value: {'items': final List<Object?> items}) => <({double cents, DateTime date})>[
      for (final Object? item in items)
        if (item case {
          'price': final num price,
          'currency': 'EUR',
          'price_per': final String pricePer,
          'date': final String date,
        } when price > 0 && pricePer == per)
          if (DateTime.tryParse(date) case final DateTime parsed) (cents: price * 100, date: parsed),
    ],
    _ => const <({double cents, DateTime date})>[],
  };
  if (prices.isEmpty) return none();
  final List<double> sorted = prices.map((it) => it.cents).toList()..sort();
  double at(double percentile) => sorted[((sorted.length - 1) * percentile).round()];
  return some(
    OpenPriceStats(
      tag: tag,
      basis: basis,
      cents: at(0.5),
      lowCents: at(lowPercentile),
      highCents: at(highPercentile),
      observations: prices.length,
      lastSeen: prices.map((it) => it.date).reduce((DateTime a, DateTime b) => a.isAfter(b) ? a : b),
    ),
  );
}
