import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/data/mappers/store_mapper.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';

void main() {
  test('reads the shops and markets of Overpass', () {
    final List<Store> stores = overpassToStores('''
{"elements": [
  {"type": "node", "id": 1, "lat": 45.76, "lon": 4.83,
   "tags": {"shop": "supermarket", "name": "Monoprix", "opening_hours": "Mo-Sa 08:00-21:00",
            "addr:housenumber": "12", "addr:street": "Rue de la République"}},
  {"type": "way", "id": 2, "center": {"lat": 45.77, "lon": 4.84},
   "tags": {"amenity": "marketplace", "name": "Marché Saint-Antoine"}},
  {"type": "node", "id": 3, "lat": 45.75, "lon": 4.82, "tags": {"shop": "convenience", "brand": "Franprix"}},
  {"type": "node", "id": 4, "lat": 45.75, "lon": 4.82, "tags": {"shop": "clothes", "name": "Mode"}},
  {"type": "node", "id": 5, "tags": {"shop": "bakery"}}
]}''');
    expect(stores.map((Store it) => it.id.value), ['node/1', 'way/2', 'node/3']);
    expect(stores.first.address, some('12 Rue de la République'));
    expect(stores.first.openingHours, some('Mo-Sa 08:00-21:00'));
    expect(stores[1].kind, StoreKind.marketplace);
    expect(stores[1].coordinates.latitude, 45.77);
    expect(stores[2].name, some('Franprix'));
  });

  test('reads the centre of a town from the Base Adresse Nationale', () {
    final coordinates = banToCoordinates('{"features": [{"geometry": {"coordinates": [4.835, 45.758]}}]}');
    expect(coordinates.map((it) => (it.latitude, it.longitude)), some((45.758, 4.835)));
    expect(banToCoordinates('{"features": []}').isNone(), isTrue);
  });
}
