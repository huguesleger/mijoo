import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/household/data/data_sources/firestore_household_data_source.dart';
import 'package:mijoo/features/household/data/mappers/household_mapper.dart';

final class HouseholdRepositoryImpl implements HouseholdRepository {
  const HouseholdRepositoryImpl(this._source);

  final FirestoreHouseholdDataSource _source;

  @override
  Stream<Option<Household>> watchHousehold(AccountId account) => _source
      .watchHousehold(account.value)
      .map(
        (snapshot) => snapshot.map(
          (snapshot) => firestoreToHousehold(snapshot.id, snapshot.data),
        ),
      );

  @override
  TaskEither<AppFailure, HouseholdId> createHousehold(AccountId account) =>
      _source.createHousehold(account.value).map(HouseholdId.new);

  @override
  TaskEither<AppFailure, Unit> saveProfile(
    HouseholdId household,
    HouseholdProfile profile,
  ) => _source.saveProfile(
    household.value,
    householdProfileToFirestore(profile),
  );

  @override
  Stream<Either<AppFailure, List<HouseholdMember>>> watchMembers(HouseholdId household) => _source
      .watchMembers(household.value)
      .map(
        (Either<AppFailure, List<FirestoreData>> result) => result.map(
          (List<FirestoreData> members) => <HouseholdMember>[
            for (final FirestoreData data in members)
              if (firestoreToHouseholdMember(data).toNullable() case final HouseholdMember member) member,
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> saveMember(HouseholdId household, HouseholdMember member) =>
      _source.saveMember(household.value, member.id.value, member.name);

  @override
  TaskEither<AppFailure, InviteCode> createInvite(HouseholdId household, AccountId account) =>
      _source.createInvite(household.value, account.value).map(InviteCode.new);

  @override
  TaskEither<AppFailure, Unit> joinHousehold(HouseholdMember member, InviteCode code) =>
      _source.joinHousehold(member.id.value, member.name, code.value);

  @override
  TaskEither<AppFailure, Unit> leaveHousehold(HouseholdId household, AccountId account) =>
      _source.leaveHousehold(household.value, account.value);
}
