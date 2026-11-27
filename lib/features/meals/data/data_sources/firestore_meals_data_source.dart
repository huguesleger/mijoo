import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/meals/data/mappers/meal_idea_mapper.dart';
import 'package:mijoo/features/meals/data/mappers/week_meal_mapper.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';

final class FirestoreMealsDataSource {
  FirestoreMealsDataSource(this._connection);

  static const String currentPlan = 'current';
  static const int recentMeals = 20;

  final FirebaseConnection _connection;

  Stream<Either<AppFailure, Option<MealPlanData>>> watchPlan(String householdId) => _connection.isConfigured
      ? Stream<FirebaseFirestore>.fromFuture(_connection.firestore)
            .asyncExpand((FirebaseFirestore firestore) => _plan(firestore, householdId).snapshots())
            .map(
              (DocumentSnapshot<MealPlanData> snapshot) =>
                  Either<AppFailure, Option<MealPlanData>>.right(Option<MealPlanData>.fromNullable(snapshot.data())),
            )
            .transform(
              StreamTransformer<
                Either<AppFailure, Option<MealPlanData>>,
                Either<AppFailure, Option<MealPlanData>>
              >.fromHandlers(
                handleError:
                    (Object error, StackTrace stack, EventSink<Either<AppFailure, Option<MealPlanData>>> sink) {
                      log('watch ${_code(error)}', name: 'mijoo.meals', stackTrace: stack);
                      sink.add(Either<AppFailure, Option<MealPlanData>>.left(_failure(error)));
                    },
              ),
            )
      : Stream<Either<AppFailure, Option<MealPlanData>>>.value(
          Either<AppFailure, Option<MealPlanData>>.left(const MealsUnavailable()),
        );

  TaskEither<AppFailure, List<String>> recentMealTitles(String householdId) =>
      _perform((FirebaseFirestore firestore) async {
        final QuerySnapshot<Map<String, Object?>> snapshot = await _cooked(
          firestore,
          householdId,
        ).orderBy('cookedAt', descending: true).limit(recentMeals).get();
        return <String>[
          for (final QueryDocumentSnapshot<Map<String, Object?>> document in snapshot.docs)
            if (document.data()['title'] case final String title) title,
        ];
      });

  TaskEither<AppFailure, Unit> savePlan(String householdId, MealPlanData data) =>
      _perform((FirebaseFirestore firestore) async {
        await _plan(firestore, householdId).set(<String, Object?>{...data, 'createdAt': FieldValue.serverTimestamp()});
        return unit;
      });

  TaskEither<AppFailure, Unit> recordCookedMeal(String householdId, String title) =>
      _perform((FirebaseFirestore firestore) async {
        await _cooked(firestore, householdId).add(<String, Object?>{
          'title': title,
          'cookedAt': FieldValue.serverTimestamp(),
        });
        return unit;
      });

  Stream<Either<AppFailure, List<WeekMealData>>> watchWeek(String householdId) => _connection.isConfigured
      ? Stream<FirebaseFirestore>.fromFuture(_connection.firestore)
            .asyncExpand((FirebaseFirestore firestore) => _week(firestore, householdId).snapshots())
            .map(
              (QuerySnapshot<WeekMealData> snapshot) => Either<AppFailure, List<WeekMealData>>.right(<WeekMealData>[
                for (final QueryDocumentSnapshot<WeekMealData> document in snapshot.docs) document.data(),
              ]),
            )
            .transform(
              StreamTransformer<
                Either<AppFailure, List<WeekMealData>>,
                Either<AppFailure, List<WeekMealData>>
              >.fromHandlers(
                handleError: (Object error, StackTrace stack, EventSink<Either<AppFailure, List<WeekMealData>>> sink) {
                  log('week ${_code(error)}', name: 'mijoo.meals', stackTrace: stack);
                  sink.add(Either<AppFailure, List<WeekMealData>>.left(_failure(error)));
                },
              ),
            )
      : Stream<Either<AppFailure, List<WeekMealData>>>.value(
          Either<AppFailure, List<WeekMealData>>.left(const MealsUnavailable()),
        );

  TaskEither<AppFailure, Unit> planMeal(String householdId, String ideaId, WeekMealData data) =>
      _perform((FirebaseFirestore firestore) async {
        await _week(firestore, householdId).doc(ideaId).set(<String, Object?>{
          ...data,
          'addedAt': FieldValue.serverTimestamp(),
        });
        return unit;
      });

  TaskEither<AppFailure, Unit> unplanMeal(String householdId, String ideaId) =>
      _perform((FirebaseFirestore firestore) async {
        await _week(firestore, householdId).doc(ideaId).delete();
        return unit;
      });

  TaskEither<AppFailure, Unit> markCooked(String householdId, String ideaId) =>
      _perform((FirebaseFirestore firestore) async {
        final DocumentReference<WeekMealData> meal = _week(firestore, householdId).doc(ideaId);
        if ((await meal.get()).exists) await meal.update(<String, Object?>{'status': 'cooked'});
        return unit;
      });

  CollectionReference<WeekMealData> _week(FirebaseFirestore firestore, String householdId) =>
      firestore.collection('households').doc(householdId).collection('weekMeals');

  DocumentReference<MealPlanData> _plan(FirebaseFirestore firestore, String householdId) =>
      firestore.collection('households').doc(householdId).collection('mealPlans').doc(currentPlan);

  CollectionReference<Map<String, Object?>> _cooked(FirebaseFirestore firestore, String householdId) =>
      firestore.collection('households').doc(householdId).collection('cookedMeals');

  TaskEither<AppFailure, T> _perform<T>(Future<T> Function(FirebaseFirestore) action) => _connection.isConfigured
      ? TaskEither<AppFailure, T>.tryCatch(() async => action(await _connection.firestore), (
          Object error,
          StackTrace stack,
        ) {
          log('write ${_code(error)}', name: 'mijoo.meals', stackTrace: stack);
          return _failure(error);
        })
      : TaskEither<AppFailure, T>.left(const MealsUnavailable());

  String _code(Object error) => switch (error) {
    FirebaseException(:final String code) => code,
    _ => error.runtimeType.toString(),
  };

  AppFailure _failure(Object error) => switch (error) {
    FirebaseException(code: 'permission-denied') => const MealsAccessDenied(),
    FirebaseException(code: 'unavailable' || 'deadline-exceeded') => const MealsNetworkFailure(),
    _ => const MealsUnavailable(),
  };
}
