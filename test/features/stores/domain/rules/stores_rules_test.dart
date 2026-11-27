import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/domain/entities/store_filter.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/rules/store_distance.dart';
import 'package:mijoo/features/stores/domain/rules/stores_rules.dart';

import '../../stores_fixtures.dart';

void main() {
  test('measures the distance as the crow flies', () {
    const Coordinates paris = Coordinates(latitude: 48.8566, longitude: 2.3522);
    expect(distanceMeters(lyon, paris), closeTo(391500, 1500));
    expect(distanceMeters(lyon, lyon), 0);
  });

  test('keeps the stores of the radius and the filter, nearest first', () {
    final List<NearbyStore> stores = nearbyStores(
      [
        store('Loin', north: 1500),
        store('Boulangerie', kind: StoreKind.bakery, north: 200),
        store('Proche', north: 300),
        store('Supérette', kind: StoreKind.convenience, north: 100),
      ],
      lyon,
      StoreRadius.near,
      StoreFilter.all,
    );
    expect(stores.map((NearbyStore it) => it.store.name.toNullable()), ['Supérette', 'Boulangerie', 'Proche']);
    expect(stores.first.meters, closeTo(100, 2));
  });

  test('groups the specialists', () {
    expect(matchesFilter(StoreKind.cheese, StoreFilter.specialists), isTrue);
    expect(matchesFilter(StoreKind.supermarket, StoreFilter.specialists), isFalse);
    expect(matchesFilter(StoreKind.marketplace, StoreFilter.markets), isTrue);
  });
}
