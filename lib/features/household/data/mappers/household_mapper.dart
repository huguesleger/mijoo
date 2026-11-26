import 'package:fpdart/fpdart.dart';

import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

typedef FirestoreData = Map<String, Object?>;

Household firestoreToHousehold(String id, FirestoreData data) => Household(
  id: HouseholdId(id),
  memberIds: _strings(data['memberIds']).map(AccountId.new).toList(),
  profile: Option.fromNullable(
    data['profile'],
  ).flatMap((value) => Option.tryCatch(() => value as FirestoreData)).map(_profileFromFirestore),
);

FirestoreData householdProfileToFirestore(HouseholdProfile profile) => {
  'adults': profile.adults,
  'children': profile.children,
  'likes': profile.likes,
  'exclusions': profile.exclusions,
  'allergies': profile.allergies,
  'maxPrepMinutes': profile.maxPrepMinutes,
  'weeklyBudgetCents': profile.weeklyBudgetCents.toNullable(),
  'location': profile.location
      .map<FirestoreData>(
        (location) => {
          'postalCode': location.postalCode,
          'city': location.city,
        },
      )
      .toNullable(),
};

HouseholdProfile _profileFromFirestore(FirestoreData data) => HouseholdProfile(
  adults: _int(data['adults']).getOrElse(() => 1),
  children: _int(data['children']).getOrElse(() => 0),
  likes: _strings(data['likes']),
  exclusions: _strings(data['exclusions']),
  allergies: _strings(data['allergies']),
  maxPrepMinutes: _int(data['maxPrepMinutes']).getOrElse(() => 30),
  weeklyBudgetCents: _int(data['weeklyBudgetCents']),
  location: Option.fromNullable(data['location'])
      .flatMap((value) => Option.tryCatch(() => value as FirestoreData))
      .map(
        (location) => HouseholdLocation(
          postalCode: _string(location['postalCode']),
          city: _string(location['city']),
        ),
      ),
);

Option<int> _int(Object? value) => switch (value) {
  final int number => some(number),
  _ => none(),
};

String _string(Object? value) => switch (value) {
  final String text => text,
  _ => '',
};

List<String> _strings(Object? value) => switch (value) {
  final List<Object?> items => items.whereType<String>().toList(),
  _ => const [],
};
