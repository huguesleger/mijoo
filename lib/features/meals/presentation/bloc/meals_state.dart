part of 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';

@immutable
sealed class MealsState {
  const MealsState();
}

final class MealsLoading extends MealsState {
  const MealsLoading();
}

final class MealsFailed extends MealsState {
  const MealsFailed(this.failure);

  final AppFailure failure;
}

final class MealsLoaded extends MealsState {
  const MealsLoaded({
    required this.plan,
    required this.week,
    required this.items,
    required this.shopping,
    required this.profile,
    required this.today,
    required this.craving,
    required this.generation,
  });

  final Option<MealPlan> plan;
  final List<WeekMeal> week;
  final List<FridgeItem> items;
  final ShoppingWeek shopping;
  final HouseholdProfile profile;
  final DateTime today;
  final MealCraving craving;
  final MealsGeneration generation;

  MealsLoaded copyWith({
    Option<MealPlan>? plan,
    List<WeekMeal>? week,
    List<FridgeItem>? items,
    ShoppingWeek? shopping,
    DateTime? today,
    MealCraving? craving,
    MealsGeneration? generation,
  }) => MealsLoaded(
    plan: plan ?? this.plan,
    week: week ?? this.week,
    items: items ?? this.items,
    shopping: shopping ?? this.shopping,
    profile: profile,
    today: today ?? this.today,
    craving: craving ?? this.craving,
    generation: generation ?? this.generation,
  );
}

@immutable
sealed class MealsGeneration {
  const MealsGeneration();
}

final class MealsIdle extends MealsGeneration {
  const MealsIdle();
}

final class MealsGenerating extends MealsGeneration {
  const MealsGenerating();
}

final class MealsGenerationFailed extends MealsGeneration {
  const MealsGenerationFailed(this.failure);

  final AppFailure failure;
}
