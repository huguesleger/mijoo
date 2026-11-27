import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';

extension type const StoreId(String value) {}

final class Store {
  const Store({
    required this.id,
    required this.name,
    required this.kind,
    required this.coordinates,
    required this.address,
    required this.openingHours,
  });

  final StoreId id;
  final Option<String> name;
  final StoreKind kind;
  final Coordinates coordinates;
  final Option<String> address;
  final Option<String> openingHours;
}
