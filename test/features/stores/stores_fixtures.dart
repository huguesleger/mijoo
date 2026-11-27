import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';

const Coordinates lyon = Coordinates(latitude: 45.7640, longitude: 4.8357);

Store store(
  String name, {
  StoreKind kind = StoreKind.supermarket,
  double north = 0,
  String? hours,
  String? address,
}) => Store(
  id: StoreId('node/$name'),
  name: some(name),
  kind: kind,
  coordinates: Coordinates(latitude: lyon.latitude + north / 111195, longitude: lyon.longitude),
  address: Option<String>.fromNullable(address),
  openingHours: Option<String>.fromNullable(hours),
);
