import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/stores/data/data_sources/overpass_data_source.dart';
import 'package:mijoo/features/stores/data/data_sources/stores_cache_data_source.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/stores_failure.dart';
import 'package:mocktail/mocktail.dart';

import '../../stores_fixtures.dart';

class MockStoresCacheDataSource extends Mock implements StoresCacheDataSource {}

void main() {
  const String bakery =
      '{"elements": [{"type": "node", "id": 7, "lat": 45.76, "lon": 4.83, "tags": {"shop": "bakery", "name": "Fournil"}}]}';
  final DateTime now = DateTime(2026, 11, 27, 10);
  late MockStoresCacheDataSource cache;

  setUpAll(() => registerFallbackValue(<Store>[]));

  setUp(() {
    cache = MockStoresCacheDataSource();
    when(() => cache.read(any())).thenReturn(Task.of(none()));
    when(() => cache.write(any(), any(), any())).thenReturn(Task.of(unit));
  });

  OverpassDataSource source(List<int> statuses) {
    final List<int> remaining = [...statuses];
    return OverpassDataSource(
      cache: cache,
      clock: () => now,
      retryDelay: Duration.zero,
      client: MockClient((http.Request request) async {
        final int status = remaining.removeAt(0);
        return http.Response(status == 200 ? bakery : '', status);
      }),
    );
  }

  test('tries once more when the server is overloaded', () async {
    final result = await source([429, 200]).storesAround(lyon, StoreRadius.near, remember: false).run();
    expect(result.map((stores) => stores.single.name), right<AppFailure, Option<String>>(some('Fournil')));
    verifyNever(() => cache.read(any()));
  });

  test('says the service is busy after a second refusal', () async {
    final result = await source([504, 504]).storesAround(lyon, StoreRadius.near, remember: false).run();
    expect(result, left<AppFailure, List<Store>>(const StoresBusy()));
  });

  test('remembers the stores of the town on the device', () async {
    await source([200]).storesAround(lyon, StoreRadius.near, remember: true).run();
    verify(() => cache.write(any(), any(that: hasLength(1)), now)).called(1);
  });

  test('falls back on the stores kept on the device when the server fails', () async {
    when(() => cache.read(any())).thenReturn(
      Task.of(some((stores: [store('Ancien')], at: now.subtract(const Duration(days: 30))))),
    );
    final result = await source([500]).storesAround(lyon, StoreRadius.near, remember: true).run();
    expect(result.map((stores) => stores.single.name), right<AppFailure, Option<String>>(some('Ancien')));
  });
}
