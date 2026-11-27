import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';

abstract interface class StoresRepository {
  TaskEither<AppFailure, Coordinates> locateTown(HouseholdLocation town);

  TaskEither<AppFailure, Coordinates> currentPosition();

  TaskEither<AppFailure, List<Store>> storesAround(Coordinates center, StoreRadius radius, {required bool remember});
}
