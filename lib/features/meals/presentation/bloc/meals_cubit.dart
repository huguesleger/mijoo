import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/meal_request.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/meals/domain/rules/meal_restrictions.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_week.dart';
import 'package:mijoo/features/shopping/domain/rules/week_budget_rules.dart';
import 'package:mijoo/features/shopping/domain/use_cases/watch_shopping_week.dart';

part 'package:mijoo/features/meals/presentation/bloc/meals_state.dart';

final class MealsCubit extends SafeCubit<MealsState> {
  MealsCubit({
    required HouseholdId household,
    required HouseholdProfile profile,
    MealsRepository? meals,
    WatchShoppingWeek? watchWeek,
    Duration? minimalLoading,
    DateTime Function()? clock,
  }) : _household = household,
       _profile = profile,
       _meals = meals ?? getIt.get<MealsRepository>(),
       _watchWeek = watchWeek ?? getIt.get<WatchShoppingWeek>(),
       _minimalLoading = minimalLoading ?? MjSkeletonizer.minDuration,
       _clock = clock ?? DateTime.now,
       super(const MealsLoading());

  final HouseholdId _household;
  final HouseholdProfile _profile;
  final MealsRepository _meals;
  final WatchShoppingWeek _watchWeek;
  final Duration _minimalLoading;
  final DateTime Function() _clock;
  StreamSubscription<Either<AppFailure, (Option<MealPlan>, ShoppingWeek)>>? _data;

  void watch() {
    unawaited(_data?.cancel());
    emit(const MealsLoading());
    _data = Stream<void>.fromFuture(Future<void>.delayed(_minimalLoading))
        .asyncExpand(
          (_) => combineLatestEither(_meals.watchPlan(_household), _watchWeek(_household, weekStart(_clock()))),
        )
        .listen(
          (Either<AppFailure, (Option<MealPlan>, ShoppingWeek)> result) => emit(
            result.match<MealsState>(
              MealsFailed.new,
              ((Option<MealPlan>, ShoppingWeek) data) => switch (state) {
                final MealsLoaded loaded => loaded.copyWith(
                  plan: data.$1,
                  week: _sorted(data.$2.facts.week),
                  items: data.$2.facts.items,
                  shopping: data.$2,
                  today: _clock(),
                ),
                MealsLoading() || MealsFailed() => MealsLoaded(
                  plan: data.$1,
                  week: _sorted(data.$2.facts.week),
                  items: data.$2.facts.items,
                  shopping: data.$2,
                  profile: _profile,
                  today: _clock(),
                  craving: data.$1.match(() => MealCraving.any, (MealPlan plan) => plan.craving),
                  generation: const MealsIdle(),
                ),
              },
            ),
          ),
        );
  }

  Future<void> choose(MealCraving craving) => switch (state) {
    MealsLoaded(generation: MealsGenerating()) => Future<void>.value(),
    final MealsLoaded loaded => _generate(loaded.copyWith(craving: craving)),
    MealsLoading() || MealsFailed() => Future<void>.value(),
  };

  Future<void> generate() => switch (state) {
    MealsLoaded(generation: MealsGenerating()) => Future<void>.value(),
    final MealsLoaded loaded => _generate(loaded),
    MealsLoading() || MealsFailed() => Future<void>.value(),
  };

  Future<void> _generate(MealsLoaded loaded) {
    emit(loaded.copyWith(generation: const MealsGenerating()));
    return _meals
        .recentMealTitles(_household)
        .orElse((_) => TaskEither<AppFailure, List<String>>.right(const <String>[]))
        .flatMap(
          (List<String> recentTitles) => _meals.suggest(
            MealRequest(
              profile: _profile,
              items: loaded.items,
              toFinishFirst: itemsToFinishFirst(loaded.items, loaded.today),
              craving: loaded.craving,
              recentTitles: recentTitles,
            ),
          ),
        )
        .map((List<MealIdea> ideas) => suitableIdeas(ideas, _profile, loaded.craving))
        .flatMap(
          (List<MealIdea> ideas) => ideas.isEmpty
              ? TaskEither<AppFailure, List<MealIdea>>.left(const MealsNothingSuitable())
              : TaskEither<AppFailure, List<MealIdea>>.fromTask(Task.traverseList(ideas, _withPhoto)),
        )
        .flatMap(
          (List<MealIdea> ideas) =>
              _meals.savePlan(_household, MealPlan(ideas: ideas, craving: loaded.craving, createdAt: _clock())),
        )
        .withMinimalDelay(_minimalLoading)
        .match<MealsGeneration>(MealsGenerationFailed.new, (_) => const MealsIdle())
        .map(
          (MealsGeneration generation) => switch (state) {
            final MealsLoaded current => emit(current.copyWith(generation: generation)),
            MealsLoading() || MealsFailed() => null,
          },
        )
        .run();
  }

  List<WeekMeal> _sorted(List<WeekMeal> week) =>
      week.toList()..sort((WeekMeal a, WeekMeal b) => a.addedAt.compareTo(b.addedAt));

  Task<MealIdea> _withPhoto(MealIdea idea) =>
      _meals.findPhoto(idea.photoQueries).map((Option<Uri> photo) => idea.copyWith(photo: photo));

  @override
  Future<void> close() async {
    await _data?.cancel();
    return super.close();
  }
}
