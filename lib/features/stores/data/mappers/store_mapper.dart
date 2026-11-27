import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';

List<Store> overpassToStores(String body) => switch (jsonDecode(body)) {
  {'elements': final List<dynamic> elements} =>
    elements
        .whereType<Map<String, dynamic>>()
        .map(overpassElementToStore)
        .whereType<Some<Store>>()
        .map(
          (Some<Store> store) => store.value,
        )
        .toList(),
  _ => const <Store>[],
};

Option<Store> overpassElementToStore(Map<String, dynamic> element) => switch (element) {
  {'type': final String type, 'id': final int id, 'tags': final Map<String, dynamic> tags} =>
    _coordinates(element).flatMap(
      (Coordinates coordinates) => _kind(tags).map(
        (StoreKind kind) => Store(
          id: StoreId('$type/$id'),
          name: _text(tags['name']).alt(() => _text(tags['brand'])),
          kind: kind,
          coordinates: coordinates,
          address: _text(tags['addr:street']).map(
            (String street) =>
                _text(tags['addr:housenumber']).match(() => street, (String number) => '$number $street'),
          ),
          openingHours: _text(tags['opening_hours']),
        ),
      ),
    ),
  _ => none(),
};

Option<Coordinates> _coordinates(Map<String, dynamic> element) => switch (element) {
  {'lat': final num latitude, 'lon': final num longitude} ||
  {'center': {'lat': final num latitude, 'lon': final num longitude}} => some(
    Coordinates(latitude: latitude.toDouble(), longitude: longitude.toDouble()),
  ),
  _ => none(),
};

Option<StoreKind> _kind(Map<String, dynamic> tags) => tags['amenity'] == 'marketplace'
    ? some(StoreKind.marketplace)
    : switch (tags['shop']) {
        'supermarket' => some(StoreKind.supermarket),
        'convenience' => some(StoreKind.convenience),
        'bakery' => some(StoreKind.bakery),
        'butcher' => some(StoreKind.butcher),
        'greengrocer' => some(StoreKind.greengrocer),
        'organic' => some(StoreKind.organic),
        'cheese' => some(StoreKind.cheese),
        'frozen_food' => some(StoreKind.frozenFood),
        _ => none(),
      };

Option<String> _text(Object? value) => switch (value) {
  final String text when text.trim().isNotEmpty => some(text.trim()),
  _ => none(),
};

Option<Coordinates> banToCoordinates(String body) => switch (jsonDecode(body)) {
  {'features': [{'geometry': {'coordinates': [final num longitude, final num latitude]}}, ...]} => some(
    Coordinates(latitude: latitude.toDouble(), longitude: longitude.toDouble()),
  ),
  _ => none(),
};

Map<String, Object?> storeToJson(Store store) => <String, Object?>{
  'id': store.id.value,
  'name': store.name.toNullable(),
  'kind': store.kind.name,
  'latitude': store.coordinates.latitude,
  'longitude': store.coordinates.longitude,
  'address': store.address.toNullable(),
  'openingHours': store.openingHours.toNullable(),
};

Option<Store> jsonToStore(Object? json) => switch (json) {
  {
    'id': final String id,
    'kind': final String kind,
    'latitude': final num latitude,
    'longitude': final num longitude,
  } =>
    Option<StoreKind>.fromNullable(StoreKind.values.asNameMap()[kind]).map(
      (StoreKind kind) => Store(
        id: StoreId(id),
        name: _text((json as Map<String, dynamic>)['name']),
        kind: kind,
        coordinates: Coordinates(latitude: latitude.toDouble(), longitude: longitude.toDouble()),
        address: _text(json['address']),
        openingHours: _text(json['openingHours']),
      ),
    ),
  _ => none(),
};

String cachedStoresToJson(List<Store> stores, DateTime at) => jsonEncode(<String, Object?>{
  'at': at.toIso8601String(),
  'stores': stores.map(storeToJson).toList(),
});

Option<({List<Store> stores, DateTime at})> jsonToCachedStores(String body) => switch (jsonDecode(body)) {
  {'at': final String at, 'stores': final List<dynamic> stores} =>
    Option<DateTime>.fromNullable(
      DateTime.tryParse(at),
    ).map(
      (DateTime at) => (
        stores: stores.map(jsonToStore).whereType<Some<Store>>().map((Some<Store> store) => store.value).toList(),
        at: at,
      ),
    ),
  _ => none(),
};
