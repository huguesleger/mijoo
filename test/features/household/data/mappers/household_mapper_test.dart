import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/data/mappers/household_mapper.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

void main() {
  const profile = HouseholdProfile(
    adults: 2,
    children: 2,
    likes: ['pâtes'],
    exclusions: ['porc'],
    allergies: ['arachide'],
    maxPrepMinutes: 30,
    weeklyBudgetCents: Some(12000),
    location: Some(HouseholdLocation(postalCode: '69001', city: 'Lyon')),
  );

  test('reads a household without profile', () {
    final household = firestoreToHousehold('h1', {
      'memberIds': ['camille'],
      'profile': null,
    });
    expect(household.id.value, 'h1');
    expect(household.memberIds, [const AccountId('camille')]);
    expect(household.profile.isNone(), isTrue);
  });

  test('writes and reads back the same profile', () {
    final household = firestoreToHousehold('h1', {
      'memberIds': ['camille'],
      'profile': householdProfileToFirestore(profile),
    });
    final read = household.profile.toNullable()!;
    expect(read.people, 4);
    expect(read.exclusions, ['porc']);
    expect(read.allergies, ['arachide']);
    expect(read.weeklyBudgetCents, const Some(12000));
    expect(read.location.map((location) => location.city), const Some('Lyon'));
  });

  test('keeps optional budget and location absent', () {
    final data = householdProfileToFirestore(
      const HouseholdProfile(
        adults: 1,
        children: 0,
        likes: [],
        exclusions: [],
        allergies: [],
        maxPrepMinutes: 20,
        weeklyBudgetCents: None(),
        location: None(),
      ),
    );
    expect(data['weeklyBudgetCents'], isNull);
    expect(data['location'], isNull);
  });
}
