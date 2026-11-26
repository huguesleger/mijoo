import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

abstract interface class HouseholdRepository {
  Stream<Option<Household>> watchHousehold(AccountId account);
  TaskEither<AppFailure, HouseholdId> createHousehold(AccountId account);
  TaskEither<AppFailure, Unit> saveProfile(
    HouseholdId household,
    HouseholdProfile profile,
  );
}
