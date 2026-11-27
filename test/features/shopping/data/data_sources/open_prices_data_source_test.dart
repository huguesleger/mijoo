import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mijoo/features/shopping/data/data_sources/open_prices_data_source.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

void main() {
  final body = jsonEncode({
    'items': [
      {'price': 1.2, 'currency': 'EUR', 'price_per': 'KILOGRAM', 'date': '2026-11-16'},
    ],
  });

  test('asks Open Prices once, then answers from its cache', () async {
    var calls = 0;
    var now = DateTime(2026, 11, 27, 10);
    final source = OpenPricesDataSource(
      client: MockClient((request) async {
        calls++;
        expect(request.url.queryParameters['category_tag'], 'en:carrots');
        expect(request.url.queryParameters['currency'], 'EUR');
        return http.Response(body, 200);
      }),
      clock: () => now,
    );
    expect((await source.stats('en:carrots', PriceBasis.kilogram).run()).map((it) => it.cents), some(120.0));
    await source.stats('en:carrots', PriceBasis.kilogram).run();
    expect(calls, 1);
    now = now.add(const Duration(days: 1));
    await source.stats('en:carrots', PriceBasis.kilogram).run();
    expect(calls, 2);
  });

  test('gives no price when the service fails', () async {
    final source = OpenPricesDataSource(client: MockClient((_) async => throw Exception('hors ligne')));
    expect(await source.stats('en:carrots', PriceBasis.kilogram).run(), isA<None>());
  });
}
