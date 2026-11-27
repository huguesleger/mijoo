part of 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';

@immutable
sealed class MealDetailState {
  const MealDetailState();
}

final class MealDetailLoading extends MealDetailState {
  const MealDetailLoading();
}

final class MealDetailFailed extends MealDetailState {
  const MealDetailFailed(this.failure);

  final AppFailure failure;
}

final class MealDetailMissing extends MealDetailState {
  const MealDetailMissing();
}

final class MealDetailReady extends MealDetailState {
  const MealDetailReady({
    required this.idea,
    required this.items,
    required this.profile,
    required this.today,
    required this.servings,
    required this.week,
    required this.tab,
    required this.cooking,
    required this.writeFailure,
  });

  final MealIdea idea;
  final List<FridgeItem> items;
  final HouseholdProfile profile;
  final DateTime today;
  final int servings;
  final Option<WeekMeal> week;
  final MealDetailTab tab;
  final MealCooking cooking;
  final Option<AppFailure> writeFailure;

  MealIdea get meal => mealForServings(idea, servings);

  MealDetailReady copyWith({
    MealIdea? idea,
    List<FridgeItem>? items,
    DateTime? today,
    int? servings,
    Option<WeekMeal>? week,
    MealDetailTab? tab,
    MealCooking? cooking,
    Option<AppFailure>? writeFailure,
  }) => MealDetailReady(
    idea: idea ?? this.idea,
    items: items ?? this.items,
    profile: profile,
    today: today ?? this.today,
    servings: servings ?? this.servings,
    week: week ?? this.week,
    tab: tab ?? this.tab,
    cooking: cooking ?? this.cooking,
    writeFailure: writeFailure ?? this.writeFailure,
  );
}

enum MealDetailTab { ingredients, steps }

@immutable
sealed class MealCooking {
  const MealCooking();
}

final class MealCookingIdle extends MealCooking {
  const MealCookingIdle();
}

final class MealCookingSaving extends MealCooking {
  const MealCookingSaving();
}

final class MealCookingFailed extends MealCooking {
  const MealCookingFailed(this.failure);

  final AppFailure failure;
}

final class MealCookingDone extends MealCooking {
  const MealCookingDone();
}
