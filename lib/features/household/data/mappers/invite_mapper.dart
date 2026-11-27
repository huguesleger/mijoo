import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';

Either<AppFailure, String> firestoreToInviteHousehold(Map<String, Object?>? data, DateTime now) => switch (data) {
  null => left(const InviteNotFound()),
  {'usedBy': final String _} => left(const InviteAlreadyUsed()),
  {'expiresAt': final Timestamp expiresAt} when !expiresAt.toDate().isAfter(now) => left(const InviteExpired()),
  {'householdId': final String householdId} => right(householdId),
  _ => left(const InviteNotFound()),
};
