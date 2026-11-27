import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_filter.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/rules/store_distance.dart';

bool matchesFilter(StoreKind kind, StoreFilter filter) => switch (filter) {
  StoreFilter.all => true,
  StoreFilter.supermarkets => kind == StoreKind.supermarket,
  StoreFilter.local => kind == StoreKind.convenience,
  StoreFilter.bakeries => kind == StoreKind.bakery,
  StoreFilter.markets => kind == StoreKind.marketplace,
  StoreFilter.specialists => switch (kind) {
    StoreKind.butcher || StoreKind.greengrocer || StoreKind.organic || StoreKind.cheese || StoreKind.frozenFood => true,
    StoreKind.supermarket || StoreKind.convenience || StoreKind.bakery || StoreKind.marketplace => false,
  },
};

List<NearbyStore> nearbyStores(List<Store> stores, Coordinates center, StoreRadius radius, StoreFilter filter) =>
    stores
        .where((Store store) => matchesFilter(store.kind, filter))
        .map((Store store) => NearbyStore(store: store, meters: distanceMeters(center, store.coordinates)))
        .where((NearbyStore nearby) => nearby.meters <= radius.meters)
        .toList()
      ..sort((NearbyStore a, NearbyStore b) => a.meters.compareTo(b.meters));
