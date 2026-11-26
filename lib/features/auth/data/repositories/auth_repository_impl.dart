import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/data/mappers/account_mapper.dart';
import 'package:mijoo/features/auth/data/data_sources/firebase_auth_data_source.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._source);

  final FirebaseAuthDataSource _source;

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

  @override
  TaskEither<AppFailure, Unit> sendPasswordReset(String email) => _source.sendPasswordReset(email);

  @override
  Stream<Option<Account>> watchSession() => _source.watchUser().map((user) => user.map(firebaseUserToAccount));
}
