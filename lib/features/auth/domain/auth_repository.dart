import 'package:fpdart/fpdart.dart';

import '../../../core/domain/app_failure.dart';
import 'account.dart';

abstract interface class AuthRepository {
  TaskEither<AppFailure, Account> signIn(String email, String password);
  TaskEither<AppFailure, Account> register(
    String name,
    String email,
    String password,
  );
  TaskEither<AppFailure, Unit> signOut();
}
