import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/data/mappers/invite_mapper.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';

void main() {
  final now = DateTime(2026, 11, 27, 12);
  Map<String, Object?> invite({Object? usedBy, int hours = 48}) => {
    'householdId': 'h1',
    'usedBy': usedBy,
    'expiresAt': Timestamp.fromDate(now.add(Duration(hours: hours))),
  };

  test('accepts a valid code and gives its household', () {
    expect(firestoreToInviteHousehold(invite(), now), right<Never, String>('h1'));
  });

  test('explains why a code cannot be used', () {
    expect(firestoreToInviteHousehold(null, now), left<InviteNotFound, Never>(const InviteNotFound()));
    expect(
      firestoreToInviteHousehold(invite(usedBy: 'alex'), now),
      left<InviteAlreadyUsed, Never>(const InviteAlreadyUsed()),
    );
    expect(firestoreToInviteHousehold(invite(hours: -1), now), left<InviteExpired, Never>(const InviteExpired()));
  });
}
