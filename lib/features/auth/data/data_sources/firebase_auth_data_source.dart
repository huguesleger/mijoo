import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/auth/domain/auth_failure.dart';

final class FirebaseAuthDataSource {
  FirebaseAuthDataSource(this._connection);

  final FirebaseConnection _connection;
  late final _auth = _connection.auth;

  TaskEither<AppFailure, User> signIn(String email, String password) => _perform((auth) async {
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

  TaskEither<AppFailure, Unit> sendPasswordReset(String email) => _perform((auth) async {
    await auth.setLanguageCode('fr');
    await auth.sendPasswordResetEmail(email: email);
    return unit;
  });

  Stream<Option<User>> watchUser() => _connection.isConfigured
      ? Stream.fromFuture(_auth)
            .asyncExpand((auth) => auth.userChanges())
            .map(Option.fromNullable)
            .transform(
              StreamTransformer.fromHandlers(
                handleError: (error, stack, sink) {
                  log('session', name: 'mijoo.auth', stackTrace: stack);
                  sink.add(const None());
                },
              ),
            )
      : Stream.value(const None());

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
            'invalid-credential' || 'wrong-password' || 'user-not-found' => const InvalidCredentials(),
            'email-already-in-use' => const EmailAlreadyUsed(),
            'weak-password' => const WeakPassword(),
            'invalid-email' => const InvalidEmail(),
            'network-request-failed' => const AuthNetworkFailure(),
            _ => const UnknownFailure(),
          };
        })
      : TaskEither.left(const FirebaseUnavailable());
}
