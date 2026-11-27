import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/meals/domain/rules/meal_deductions.dart';
import 'package:mijoo/features/meals/domain/rules/meal_servings.dart';

part 'package:mijoo/features/meals/presentation/bloc/meal_detail_state.dart';

final class MealDetailCubit extends SafeCubit<MealDetailState> {
  MealDetailCubit({
    required HouseholdId household,
    required HouseholdProfile profile,
    required MealIdeaId idea,
    MealsRepository? meals,
    FridgeRepository? fridge,
    Duration? minimalLoading,
    DateTime Function()? clock,
  }) : _household = household,
       _profile = profile,
       _idea = idea,
       _meals = meals ?? getIt.get<MealsRepository>(),
       _fridge = fridge ?? getIt.get<FridgeRepository>(),
       _minimalLoading = minimalLoading ?? MjLoader.minDuration,
       _clock = clock ?? DateTime.now,
       super(const MealDetailLoading());

  final HouseholdId _household;
  final HouseholdProfile _profile;
  final MealIdeaId _idea;
  final MealsRepository _meals;
  final FridgeRepository _fridge;
  final Duration _minimalLoading;
  final DateTime Function() _clock;
  StreamSubscription<Either<AppFailure, ((Option<MealPlan>, List<WeekMeal>), List<FridgeItem>)>>? _data;

  void watch() {
    unawaited(_data?.cancel());
    emit(const MealDetailLoading());
    _data =
        combineLatestEither(
          combineLatestEither(_meals.watchPlan(_household), _meals.watchWeek(_household)),
          _fridge.watchItems(_household),
        ).listen(
          (Either<AppFailure, ((Option<MealPlan>, List<WeekMeal>), List<FridgeItem>)> result) => switch (state) {
            MealDetailReady(cooking: MealCookingSaving() || MealCookingDone()) => null,
            MealDetailReady() || MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => emit(
              result.match<MealDetailState>(
                MealDetailFailed.new,
                (((Option<MealPlan>, List<WeekMeal>), List<FridgeItem>) data) => _ready(
                  plan: data.$1.$1,
                  week: Option<WeekMeal>.fromNullable(
                    data.$1.$2.where((WeekMeal meal) => meal.idea.id == _idea).firstOrNull,
                  ),
                  items: data.$2,
                ),
              ),
            ),
          },
        );
  }

  MealDetailState _ready({
    required Option<MealPlan> plan,
    required Option<WeekMeal> week,
    required List<FridgeItem> items,
  }) => week
      .map((WeekMeal meal) => meal.idea)
      .alt(() => plan.flatMap((MealPlan plan) => plan.idea(_idea)))
      .match<MealDetailState>(
        () => const MealDetailMissing(),
        (MealIdea idea) => switch (state) {
          final MealDetailReady ready => ready.copyWith(
            idea: idea,
            items: items,
            today: _clock(),
            week: week,
            servings: week.isSome() ? idea.servings : ready.servings,
          ),
          MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => MealDetailReady(
            idea: idea,
            items: items,
            profile: _profile,
            today: _clock(),
            servings: idea.servings,
            week: week,
            tab: MealDetailTab.ingredients,
            cooking: const MealCookingIdle(),
            writeFailure: none(),
          ),
        },
      );

  Future<void> changeServings(int servings) => switch (state) {
    final MealDetailReady ready => _changeServings(ready, servings.clamp(minServings, maxServings)),
    MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => Future<void>.value(),
  };

  Future<void> _changeServings(MealDetailReady ready, int servings) {
    final MealDetailReady changed = ready.copyWith(servings: servings);
    emit(changed);
    return switch (ready.week) {
      Some(value: WeekMeal(status: WeekMealStatus.planned)) => _write(_meals.planMeal(_household, changed.meal)),
      Some() || None() => Future<void>.value(),
    };
  }

  Future<void> toggleWeek() => switch (state) {
    MealDetailReady(week: Some()) => _write(_meals.unplanMeal(_household, _idea)),
    final MealDetailReady ready => _write(_meals.planMeal(_household, ready.meal)),
    MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => Future<void>.value(),
  };

  Future<void> _write(TaskEither<AppFailure, Unit> operation) => operation
      .match<Option<AppFailure>>(some, (_) => none())
      .map(
        (Option<AppFailure> failure) => switch (state) {
          final MealDetailReady ready => emit(ready.copyWith(writeFailure: failure)),
          MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => null,
        },
      )
      .run();

  void showTab(MealDetailTab tab) => switch (state) {
    final MealDetailReady ready => emit(ready.copyWith(tab: tab)),
    MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => null,
  };

  Future<void> cook(List<MealDeduction> deductions) => switch (state) {
    MealDetailReady(cooking: MealCookingSaving() || MealCookingDone()) => Future<void>.value(),
    final MealDetailReady ready => _cook(ready, deductions),
    MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => Future<void>.value(),
  };

  Future<void> _cook(MealDetailReady ready, List<MealDeduction> deductions) {
    emit(ready.copyWith(cooking: const MealCookingSaving()));
    return TaskEither.traverseListSeq<AppFailure, MealDeduction, Unit>(deductions, _deduct)
        .flatMap((_) => _meals.recordCookedMeal(_household, ready.idea.title))
        .flatMap(
          (_) => ready.week.isSome() ? _meals.markCooked(_household, _idea) : TaskEither<AppFailure, Unit>.right(unit),
        )
        .withMinimalDelay(_minimalLoading)
        .match<MealCooking>(MealCookingFailed.new, (_) => const MealCookingDone())
        .map(
          (MealCooking cooking) => switch (state) {
            final MealDetailReady current => emit(current.copyWith(cooking: cooking)),
            MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => null,
          },
        )
        .run();
  }

  TaskEither<AppFailure, Unit> _deduct(MealDeduction deduction) => remainingAfter(deduction).match(
    () => _fridge.deleteItem(_household, deduction.item.id),
    (FridgeItemInput input) => _fridge.updateItem(_household, deduction.item.id, input),
  );

  @override
  Future<void> close() async {
    await _data?.cancel();
    return super.close();
  }
}
