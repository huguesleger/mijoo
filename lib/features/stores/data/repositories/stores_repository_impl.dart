import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/data/data_sources/address_data_source.dart';
import 'package:mijoo/features/stores/data/data_sources/overpass_data_source.dart';
import 'package:mijoo/features/stores/data/data_sources/position_data_source.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/stores_repository.dart';

final class StoresRepositoryImpl implements StoresRepository {
  StoresRepositoryImpl(this._addresses, this._overpass, this._position);

  final AddressDataSource _addresses;
  final OverpassDataSource _overpass;
  final PositionDataSource _position;

  @override
  TaskEither<AppFailure, Coordinates> locateTown(HouseholdLocation town) => _addresses.locate(town);

  @override
  TaskEither<AppFailure, Coordinates> currentPosition() => _position.current();

  @override
  TaskEither<AppFailure, List<Store>> storesAround(Coordinates center, StoreRadius radius, {required bool remember}) =>
      _overpass.storesAround(center, radius, remember: remember);
}
