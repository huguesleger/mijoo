import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/auth/domain/auth_failure.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';

String failureMessage(AppFailure failure) => switch (failure) {
  FirebaseUnavailable() => t.auth.firebaseUnavailable,
  InvalidCredentials() => t.auth.invalidCredentials,
  EmailAlreadyUsed() => t.auth.emailAlreadyUsed,
  WeakPassword() => t.auth.weakPassword,
  InvalidEmail() => t.auth.invalidEmail,
  AuthNetworkFailure() => t.auth.networkFailure,
  HouseholdUnavailable() => t.household.unavailable,
  HouseholdAccessDenied() => t.household.accessDenied,
  HouseholdNetworkFailure() => t.household.networkFailure,
  _ => t.failures.unknown,
};
