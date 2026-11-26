import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/fridge/data/mappers/fridge_item_mapper.dart';
import 'package:mijoo/features/fridge/domain/fridge_failure.dart';

typedef FridgeItemSnapshot = ({String id, FridgeItemData data});

final class FirestoreFridgeDataSource {
  FirestoreFridgeDataSource(this._connection);

  final FirebaseConnection _connection;

  Stream<Either<AppFailure, List<FridgeItemSnapshot>>> watchItems(String householdId) => _connection.isConfigured
      ? Stream<FirebaseFirestore>.fromFuture(_connection.firestore)
            .asyncExpand((FirebaseFirestore firestore) => _stock(firestore, householdId).snapshots())
            .map(
              (QuerySnapshot<FridgeItemData> snapshot) =>
                  Either<AppFailure, List<FridgeItemSnapshot>>.right(<FridgeItemSnapshot>[
                    for (final QueryDocumentSnapshot<FridgeItemData> document in snapshot.docs)
                      (id: document.id, data: document.data()),
                  ]),
            )
            .transform(
              StreamTransformer<
                Either<AppFailure, List<FridgeItemSnapshot>>,
                Either<AppFailure, List<FridgeItemSnapshot>>
              >.fromHandlers(
                handleError:
                    (Object error, StackTrace stack, EventSink<Either<AppFailure, List<FridgeItemSnapshot>>> sink) {
                      log('watch', name: 'mijoo.fridge', stackTrace: stack);
                      sink.add(Either<AppFailure, List<FridgeItemSnapshot>>.left(_failure(error)));
                    },
              ),
            )
      : Stream<Either<AppFailure, List<FridgeItemSnapshot>>>.value(
          Either<AppFailure, List<FridgeItemSnapshot>>.left(const FridgeUnavailable()),
        );

  TaskEither<AppFailure, Unit> addItem(String householdId, FridgeItemData data) =>
      _perform((FirebaseFirestore firestore) async {
        await _stock(firestore, householdId).add(<String, Object?>{
          ...data,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        return unit;
      });

  TaskEither<AppFailure, Unit> updateItem(String householdId, String itemId, FridgeItemData data) =>
      _perform((FirebaseFirestore firestore) async {
        await _stock(firestore, householdId).doc(itemId).update(<String, Object?>{
          ...data,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        return unit;
      });

  TaskEither<AppFailure, Unit> deleteItem(String householdId, String itemId) =>
      _perform((FirebaseFirestore firestore) async {
        await _stock(firestore, householdId).doc(itemId).delete();
        return unit;
      });

  CollectionReference<FridgeItemData> _stock(FirebaseFirestore firestore, String householdId) =>
      firestore.collection('households').doc(householdId).collection('stock');

  TaskEither<AppFailure, T> _perform<T>(Future<T> Function(FirebaseFirestore) action) => _connection.isConfigured
      ? TaskEither<AppFailure, T>.tryCatch(() async => action(await _connection.firestore), (
          Object error,
          StackTrace stack,
        ) {
          log('write', name: 'mijoo.fridge', stackTrace: stack);
          return _failure(error);
        })
      : TaskEither<AppFailure, T>.left(const FridgeUnavailable());

  AppFailure _failure(Object error) => switch (error) {
    FirebaseException(code: 'permission-denied') => const FridgeAccessDenied(),
    FirebaseException(code: 'unavailable' || 'deadline-exceeded') => const FridgeNetworkFailure(),
    _ => const FridgeUnavailable(),
  };
}
