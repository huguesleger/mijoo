import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/meal_request.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';

abstract interface class MealsRepository {
  Stream<Either<AppFailure, Option<MealPlan>>> watchPlan(HouseholdId household);
  TaskEither<AppFailure, List<String>> recentMealTitles(HouseholdId household);
  TaskEither<AppFailure, List<MealIdea>> suggest(MealRequest request);
  Task<Option<Uri>> findPhoto(List<String> queries);
  TaskEither<AppFailure, Unit> savePlan(HouseholdId household, MealPlan plan);
  TaskEither<AppFailure, Unit> recordCookedMeal(HouseholdId household, String title);
  Stream<Either<AppFailure, List<WeekMeal>>> watchWeek(HouseholdId household);
  TaskEither<AppFailure, Unit> planMeal(HouseholdId household, MealIdea idea);
  TaskEither<AppFailure, Unit> unplanMeal(HouseholdId household, MealIdeaId idea);
  TaskEither<AppFailure, Unit> markCooked(HouseholdId household, MealIdeaId idea);
}
