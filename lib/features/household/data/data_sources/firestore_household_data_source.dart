import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/household/data/mappers/household_mapper.dart';

typedef HouseholdSnapshot = ({String id, FirestoreData data});

final class FirestoreHouseholdDataSource {
  FirestoreHouseholdDataSource(this._connection, {Duration retryDelay = const Duration(seconds: 1)})
    : _retryDelay = retryDelay;

  static const int deniedRetries = 3;

  final FirebaseConnection _connection;
  final Duration _retryDelay;

  Stream<Option<HouseholdSnapshot>> watchHousehold(String uid) => _connection.isConfigured
      ? Stream.fromFuture(_connection.firestore)
            .asyncExpand(
              (firestore) => _users(firestore)
                  .doc(uid)
                  .snapshots()
                  .map(
                    (user) => Option.fromNullable(user.data()).flatMap(
                      (data) => switch (data['householdId']) {
                        final String id => some(id),
                        _ => none<String>(),
                      },
                    ),
                  )
                  .asyncExpand(
                    (householdId) => householdId.match(
                      () => Stream.value(none<HouseholdSnapshot>()),
                      (id) => _retryWhileDenied(
                        () => _households(firestore)
                            .doc(id)
                            .snapshots()
                            .map(
                              (household) => Option.fromNullable(
                                household.data(),
                              ).map((data) => (id: household.id, data: data)),
                            ),
                        deniedRetries,
                      ),
                    ),
                  ),
            )
            .transform(
              StreamTransformer.fromHandlers(
                handleError: (error, stack, sink) {
                  log(
                    switch (error) {
                      FirebaseException(:final code) => 'household $code',
                      _ => 'household ${error.runtimeType}',
                    },
                    name: 'mijoo.household',
                    stackTrace: stack,
                  );
                  sink.add(none());
                },
              ),
            )
      : Stream.value(none());

  TaskEither<AppFailure, String> createHousehold(String uid) => _perform((firestore) async {
    final household = _households(firestore).doc();
    final batch = firestore.batch()
      ..set(household, {
        'memberIds': [uid],
        'createdBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
        'profile': null,
      })
      ..set(_users(firestore).doc(uid), {'householdId': household.id});
    await batch.commit();
    return household.id;
  });

  TaskEither<AppFailure, Unit> saveProfile(
    String householdId,
    FirestoreData profile,
  ) => _perform((firestore) async {
    await _households(firestore).doc(householdId).update({'profile': profile});
    return unit;
  });

  Stream<T> _retryWhileDenied<T>(Stream<T> Function() open, int retries) => Stream<T>.multi((
    MultiStreamController<T> controller,
  ) {
    int retriesLeft = retries;
    StreamSubscription<T>? subscription;
    void follow(Stream<T> stream) => subscription = stream.listen(
      controller.add,
      onDone: controller.close,
      onError: (Object error, StackTrace stack) => switch (error) {
        FirebaseException(code: 'permission-denied') when retriesLeft > 0 => follow(
          Stream<void>.fromFuture(
            Future<void>.delayed(_retryDelay * (retries - --retriesLeft)),
          ).asyncExpand((_) => open()),
        ),
        _ => controller.addError(error, stack),
      },
    );
    follow(open());
    controller.onCancel = () => subscription?.cancel();
  });

  CollectionReference<FirestoreData> _users(FirebaseFirestore firestore) => firestore.collection('users');

  CollectionReference<FirestoreData> _households(FirebaseFirestore firestore) => firestore.collection('households');

  TaskEither<AppFailure, T> _perform<T>(
    Future<T> Function(FirebaseFirestore) action,
  ) => _connection.isConfigured
      ? TaskEither.tryCatch(() async => action(await _connection.firestore), (
          error,
          stack,
        ) {
          final code = switch (error) {
            FirebaseException(:final code) => code,
            _ => error.runtimeType.toString(),
          };
          log(code, name: 'mijoo.household', stackTrace: stack);
          return switch (code) {
            'permission-denied' => const HouseholdAccessDenied(),
            'unavailable' || 'deadline-exceeded' => const HouseholdNetworkFailure(),
            _ => const HouseholdUnavailable(),
          };
        })
      : TaskEither.left(const HouseholdUnavailable());
}
