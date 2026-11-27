import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/auth/domain/auth_failure.dart';
import 'package:mijoo/features/fridge/domain/fridge_failure.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';
import 'package:mijoo/features/shopping/domain/shopping_failure.dart';

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
  InviteNotFound() => t.household.inviteNotFound,
  InviteExpired() => t.household.inviteExpired,
  InviteAlreadyUsed() => t.household.inviteAlreadyUsed,
  FridgeUnavailable() => t.fridge.unavailable,
  FridgeAccessDenied() => t.fridge.accessDenied,
  FridgeNetworkFailure() => t.fridge.networkFailure,
  ScanUnavailable() => t.scan.unavailable,
  ScanNetworkFailure() => t.scan.networkFailure,
  ScanQuotaReached() => t.scan.quotaReached,
  ScanBusy() => t.scan.busy,
  ScanInvalidResponse() => t.scan.invalidResponse,
  ScanPhotoFailure() => t.scan.photoFailure,
  ScanCameraDenied() => t.scan.cameraDenied,
  ProductLookupFailure() => t.scan.productLookupFailure,
  MealsUnavailable() => t.meals.unavailable,
  MealsNetworkFailure() => t.meals.networkFailure,
  MealsAccessDenied() => t.meals.accessDenied,
  MealsBusy() => t.meals.busy,
  MealsQuotaReached() => t.meals.quotaReached,
  MealsInvalidResponse() => t.meals.invalidResponse,
  MealsNothingSuitable() => t.meals.nothingSuitable,
  ShoppingUnavailable() => t.shopping.unavailable,
  ShoppingNetworkFailure() => t.shopping.networkFailure,
  ShoppingAccessDenied() => t.shopping.accessDenied,
  _ => t.failures.unknown,
};
