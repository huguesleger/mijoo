import 'package:mijoo/core/core.dart';

final class FirebaseUnavailable extends AppFailure {
  const FirebaseUnavailable();
}

final class InvalidCredentials extends AppFailure {
  const InvalidCredentials();
}

final class EmailAlreadyUsed extends AppFailure {
  const EmailAlreadyUsed();
}

final class WeakPassword extends AppFailure {
  const WeakPassword();
}

final class InvalidEmail extends AppFailure {
  const InvalidEmail();
}

final class AuthNetworkFailure extends AppFailure {
  const AuthNetworkFailure();
}
