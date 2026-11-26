import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/domain/app_failure.dart';
import '../../../core/firebase/firebase_connection.dart';
import '../domain/auth_failure.dart';

final class FirebaseAuthSource {
  FirebaseAuthSource(this._connection);

  final FirebaseConnection _connection;
  late final _auth = _connection.connect();

  TaskEither<AppFailure, User> signIn(String email, String password) =>
      _perform((auth) async {
        final credential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return _requireUser(credential);
      });

  TaskEither<AppFailure, User> register(
    String name,
    String email,
    String password,
  ) => _perform((auth) async {
    final user = await _createOrResume(auth, email, password);
    await user.updateDisplayName(name);
    await user.reload();
    return Option.fromNullable(auth.currentUser).getOrElse(() => user);
  });

  TaskEither<AppFailure, Unit> signOut() => _perform((auth) async {
    await auth.signOut();
    return unit;
  });

  Future<User> _createOrResume(
    FirebaseAuth auth,
    String email,
    String password,
  ) => Option.fromNullable(auth.currentUser)
      .filter(
        (user) =>
            Option.fromNullable(user.email).match(
              () => false,
              (value) => value.toLowerCase() == email.toLowerCase(),
            ) &&
            Option.fromNullable(user.displayName).isNone(),
      )
      .match(
        () async => _requireUser(
          await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ),
        (_) async => _requireUser(
          await auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ),
      );

  User _requireUser(UserCredential credential) => Option.fromNullable(
    credential.user,
  ).getOrElse(() => throw StateError('Missing Firebase user'));

  TaskEither<AppFailure, T> _perform<T>(
    Future<T> Function(FirebaseAuth) action,
  ) => _connection.isConfigured
      ? TaskEither.tryCatch(() async => action(await _auth), (error, stack) {
          final code = switch (error) {
            FirebaseAuthException(:final code) => code,
            _ => error.runtimeType.toString(),
          };
          log(code, name: 'mijoo.auth', stackTrace: stack);
          return switch (code) {
            'invalid-credential' ||
            'wrong-password' ||
            'user-not-found' => const InvalidCredentials(),
            'email-already-in-use' => const EmailAlreadyUsed(),
            'weak-password' => const WeakPassword(),
            'invalid-email' => const InvalidEmail(),
            'network-request-failed' => const AuthNetworkFailure(),
            _ => const UnknownFailure(),
          };
        })
      : TaskEither.left(const FirebaseUnavailable());
}
