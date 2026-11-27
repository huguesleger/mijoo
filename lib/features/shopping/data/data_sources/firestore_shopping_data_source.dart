import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/shopping/data/mappers/shopping_entry_mapper.dart';
import 'package:mijoo/features/shopping/domain/shopping_failure.dart';

typedef ShoppingEntrySnapshot = ({String id, ShoppingEntryData data});

final class FirestoreShoppingDataSource {
  FirestoreShoppingDataSource(this._connection);

  final FirebaseConnection _connection;

  Stream<Either<AppFailure, List<ShoppingEntrySnapshot>>> watchEntries(String householdId) => _connection.isConfigured
      ? Stream<FirebaseFirestore>.fromFuture(_connection.firestore)
            .asyncExpand((FirebaseFirestore firestore) => _entries(firestore, householdId).snapshots())
            .map(
              (QuerySnapshot<ShoppingEntryData> snapshot) =>
                  Either<AppFailure, List<ShoppingEntrySnapshot>>.right(<ShoppingEntrySnapshot>[
                    for (final QueryDocumentSnapshot<ShoppingEntryData> document in snapshot.docs)
                      (id: document.id, data: document.data()),
                  ]),
            )
            .transform(
              StreamTransformer<
                Either<AppFailure, List<ShoppingEntrySnapshot>>,
                Either<AppFailure, List<ShoppingEntrySnapshot>>
              >.fromHandlers(
                handleError:
                    (Object error, StackTrace stack, EventSink<Either<AppFailure, List<ShoppingEntrySnapshot>>> sink) {
                      log('watch ${_code(error)}', name: 'mijoo.shopping', stackTrace: stack);
                      sink.add(Either<AppFailure, List<ShoppingEntrySnapshot>>.left(_failure(error)));
                    },
              ),
            )
      : Stream<Either<AppFailure, List<ShoppingEntrySnapshot>>>.value(
          Either<AppFailure, List<ShoppingEntrySnapshot>>.left(const ShoppingUnavailable()),
        );

  TaskEither<AppFailure, Unit> addEntry(String householdId, ShoppingEntryData data) => _perform((
    FirebaseFirestore firestore,
  ) async {
    await _entries(firestore, householdId).add(<String, Object?>{...data, 'updatedAt': FieldValue.serverTimestamp()});
    return unit;
  });

  TaskEither<AppFailure, Unit> saveEntry(String householdId, String entryId, ShoppingEntryData data) =>
      _perform((FirebaseFirestore firestore) async {
        await _entries(
          firestore,
          householdId,
        ).doc(entryId).set(<String, Object?>{...data, 'updatedAt': FieldValue.serverTimestamp()});
        return unit;
      });

  TaskEither<AppFailure, Unit> deleteEntries(String householdId, List<String> entryIds) =>
      _perform((FirebaseFirestore firestore) async {
        final WriteBatch batch = firestore.batch();
        for (final String entryId in entryIds) {
          batch.delete(_entries(firestore, householdId).doc(entryId));
        }
        await batch.commit();
        return unit;
      });

  Stream<Either<AppFailure, List<({String id, Map<String, Object?> data})>>> watchPrices(String householdId) =>
      _watch(householdId, 'prices', (CollectionReference<Map<String, Object?>> prices) => prices);

  Stream<Either<AppFailure, List<({String id, Map<String, Object?> data})>>> watchExpenses(
    String householdId,
    DateTime since,
  ) => _watch(
    householdId,
    'expenses',
    (CollectionReference<Map<String, Object?>> expenses) =>
        expenses.where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(since)),
  );

  TaskEither<AppFailure, Unit> savePrice(String householdId, String priceId, Map<String, Object?> data) =>
      _perform((FirebaseFirestore firestore) async {
        await firestore.collection('households').doc(householdId).collection('prices').doc(priceId).set(
          <String, Object?>{...data, 'updatedAt': FieldValue.serverTimestamp()},
        );
        return unit;
      });

  TaskEither<AppFailure, Unit> addExpense(String householdId, Map<String, Object?> data) =>
      _perform((FirebaseFirestore firestore) async {
        await firestore.collection('households').doc(householdId).collection('expenses').add(<String, Object?>{
          ...data,
          'createdAt': FieldValue.serverTimestamp(),
        });
        return unit;
      });

  TaskEither<AppFailure, Unit> deleteExpense(String householdId, String expenseId) =>
      _perform((FirebaseFirestore firestore) async {
        await firestore.collection('households').doc(householdId).collection('expenses').doc(expenseId).delete();
        return unit;
      });

  Stream<Either<AppFailure, List<({String id, Map<String, Object?> data})>>> _watch(
    String householdId,
    String collection,
    Query<Map<String, Object?>> Function(CollectionReference<Map<String, Object?>>) query,
  ) => _connection.isConfigured
      ? Stream<FirebaseFirestore>.fromFuture(_connection.firestore)
            .asyncExpand(
              (FirebaseFirestore firestore) =>
                  query(firestore.collection('households').doc(householdId).collection(collection)).snapshots(),
            )
            .map(
              (QuerySnapshot<Map<String, Object?>> snapshot) =>
                  Either<AppFailure, List<({String id, Map<String, Object?> data})>>.right(
                    <({String id, Map<String, Object?> data})>[
                      for (final QueryDocumentSnapshot<Map<String, Object?>> document in snapshot.docs)
                        (id: document.id, data: document.data()),
                    ],
                  ),
            )
            .transform(
              StreamTransformer<
                Either<AppFailure, List<({String id, Map<String, Object?> data})>>,
                Either<AppFailure, List<({String id, Map<String, Object?> data})>>
              >.fromHandlers(
                handleError:
                    (
                      Object error,
                      StackTrace stack,
                      EventSink<Either<AppFailure, List<({String id, Map<String, Object?> data})>>> sink,
                    ) {
                      log('$collection ${_code(error)}', name: 'mijoo.shopping', stackTrace: stack);
                      sink.add(
                        Either<AppFailure, List<({String id, Map<String, Object?> data})>>.left(_failure(error)),
                      );
                    },
              ),
            )
      : Stream<Either<AppFailure, List<({String id, Map<String, Object?> data})>>>.value(
          Either<AppFailure, List<({String id, Map<String, Object?> data})>>.left(const ShoppingUnavailable()),
        );

  CollectionReference<ShoppingEntryData> _entries(FirebaseFirestore firestore, String householdId) =>
      firestore.collection('households').doc(householdId).collection('shopping');

  TaskEither<AppFailure, T> _perform<T>(Future<T> Function(FirebaseFirestore) action) => _connection.isConfigured
      ? TaskEither<AppFailure, T>.tryCatch(() async => action(await _connection.firestore), (
          Object error,
          StackTrace stack,
        ) {
          log('write ${_code(error)}', name: 'mijoo.shopping', stackTrace: stack);
          return _failure(error);
        })
      : TaskEither<AppFailure, T>.left(const ShoppingUnavailable());

  String _code(Object error) => switch (error) {
    FirebaseException(:final String code) => code,
    _ => error.runtimeType.toString(),
  };

  AppFailure _failure(Object error) => switch (error) {
    FirebaseException(code: 'permission-denied') => const ShoppingAccessDenied(),
    FirebaseException(code: 'unavailable' || 'deadline-exceeded') => const ShoppingNetworkFailure(),
    _ => const ShoppingUnavailable(),
  };
}
