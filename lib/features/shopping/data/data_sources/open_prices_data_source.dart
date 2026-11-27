import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/shopping/data/mappers/open_price_mapper.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/shopping_failure.dart';

final class OpenPricesDataSource {
  OpenPricesDataSource({http.Client? client, DateTime Function()? clock})
    : _client = client ?? http.Client(),
      _clock = clock ?? DateTime.now;

  static const String host = 'prices.openfoodfacts.org';
  static const Duration timeout = Duration(seconds: 8);
  static const Duration cacheLifetime = Duration(hours: 12);
  static const int sampleSize = 60;

  final http.Client _client;
  final DateTime Function() _clock;
  final Map<String, ({Option<OpenPriceStats> stats, DateTime at})> _cache =
      <String, ({Option<OpenPriceStats> stats, DateTime at})>{};

  Task<Option<OpenPriceStats>> stats(String tag, PriceBasis basis) => switch (_cache[tag]) {
    final ({Option<OpenPriceStats> stats, DateTime at}) cached when _clock().difference(cached.at) < cacheLifetime =>
      Task<Option<OpenPriceStats>>.of(cached.stats),
    _ =>
      TaskEither<AppFailure, http.Response>.tryCatch(
        () => _client
            .get(
              Uri.https(host, '/api/v1/prices', <String, String>{
                'category_tag': tag,
                'currency': 'EUR',
                'location_osm_address_country_code': 'FR',
                'order_by': '-date',
                'size': '$sampleSize',
              }),
              headers: <String, String>{'User-Agent': 'Mijoo (application familiale)'},
            )
            .timeout(timeout),
        (Object error, StackTrace stack) {
          log('open prices ${error.runtimeType}', name: 'mijoo.shopping', stackTrace: stack);
          return const ShoppingNetworkFailure();
        },
      ).match(
        (_) => none<OpenPriceStats>(),
        (http.Response response) {
          final Option<OpenPriceStats> stats = response.statusCode == 200
              ? openPricesToStats(tag, basis, response.body)
              : none<OpenPriceStats>();
          _cache[tag] = (stats: stats, at: _clock());
          return stats;
        },
      ),
  };
}
