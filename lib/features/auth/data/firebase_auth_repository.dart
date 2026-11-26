import 'package:fpdart/fpdart.dart';

import '../../../core/domain/app_failure.dart';
import '../domain/account.dart';
import '../domain/auth_repository.dart';
import 'account_mapper.dart';
import 'firebase_auth_source.dart';

final class FirebaseAuthRepository implements AuthRepository {
  const FirebaseAuthRepository(this._source);

  final FirebaseAuthSource _source;

  @override
  TaskEither<AppFailure, Account> signIn(String email, String password) =>
      _source.signIn(email, password).map(firebaseUserToAccount);

  @override
  TaskEither<AppFailure, Account> register(
    String name,
    String email,
    String password,
  ) => _source.register(name, email, password).map(firebaseUserToAccount);

  @override
  TaskEither<AppFailure, Unit> signOut() => _source.signOut();
}
