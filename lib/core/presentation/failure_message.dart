import '../domain/app_failure.dart';
import '../i18n/translations.g.dart';
import '../../features/auth/domain/auth_failure.dart';

String failureMessage(AppFailure failure) => switch (failure) {
  FirebaseUnavailable() => t.auth.firebaseUnavailable,
  InvalidCredentials() => t.auth.invalidCredentials,
  EmailAlreadyUsed() => t.auth.emailAlreadyUsed,
  WeakPassword() => t.auth.weakPassword,
  InvalidEmail() => t.auth.invalidEmail,
  AuthNetworkFailure() => t.auth.networkFailure,
  _ => t.auth.unknownFailure,
};
