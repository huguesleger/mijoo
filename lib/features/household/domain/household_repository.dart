import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';

abstract interface class HouseholdRepository {
  Stream<Option<Household>> watchHousehold(AccountId account);
  TaskEither<AppFailure, HouseholdId> createHousehold(AccountId account);
  TaskEither<AppFailure, Unit> saveProfile(
    HouseholdId household,
    HouseholdProfile profile,
  );
  Stream<Either<AppFailure, List<HouseholdMember>>> watchMembers(HouseholdId household);
  TaskEither<AppFailure, Unit> saveMember(HouseholdId household, HouseholdMember member);
  TaskEither<AppFailure, InviteCode> createInvite(HouseholdId household, AccountId account);
  TaskEither<AppFailure, Unit> joinHousehold(HouseholdMember member, InviteCode code);
  TaskEither<AppFailure, Unit> leaveHousehold(HouseholdId household, AccountId account);
}
