import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';

abstract interface class AuthRepository {
  TaskEither<AppFailure, Account> signIn(String email, String password);
  TaskEither<AppFailure, Account> register(
    String name,
    String email,
    String password,
  );
  TaskEither<AppFailure, Unit> signOut();
  TaskEither<AppFailure, Unit> sendPasswordReset(String email);
  Stream<Option<Account>> watchSession();
}
