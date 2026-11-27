import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/data/data_sources/firestore_meals_data_source.dart';
import 'package:mijoo/features/meals/data/data_sources/gemini_meals_data_source.dart';
import 'package:mijoo/features/meals/data/data_sources/meal_db_photo_data_source.dart';
import 'package:mijoo/features/meals/data/mappers/meal_photo_mapper.dart';
import 'package:mijoo/features/meals/data/mappers/meal_idea_mapper.dart';
import 'package:mijoo/features/meals/data/mappers/meal_request_mapper.dart';
import 'package:mijoo/features/meals/data/mappers/week_meal_mapper.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/meal_request.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';

final class MealsRepositoryImpl implements MealsRepository {
  const MealsRepositoryImpl(this._firestore, this._gemini, this._photos);

  final FirestoreMealsDataSource _firestore;
  final GeminiMealsDataSource _gemini;
  final MealDbPhotoDataSource _photos;

  @override
  Stream<Either<AppFailure, Option<MealPlan>>> watchPlan(HouseholdId household) => _firestore
      .watchPlan(household.value)
      .map(
        (Either<AppFailure, Option<MealPlanData>> result) =>
            result.map((Option<MealPlanData> data) => data.flatMap(firestoreToMealPlan)),
      );

  @override
  TaskEither<AppFailure, List<String>> recentMealTitles(HouseholdId household) =>
      _firestore.recentMealTitles(household.value);

  @override
  TaskEither<AppFailure, List<MealIdea>> suggest(MealRequest request) => _gemini
      .suggest(mealRequestToPrompt(request))
      .flatMap(
        (String json) => TaskEither<AppFailure, List<MealIdea>>.fromOption(
          geminiToMealIdeas(json),
          () => const MealsInvalidResponse(),
        ),
      );

  @override
  Task<Option<Uri>> findPhoto(List<String> queries) =>
      _photos.findThumb(queries).map((Option<String> thumb) => thumb.flatMap(mealDbToPhoto));

  @override
  TaskEither<AppFailure, Unit> savePlan(HouseholdId household, MealPlan plan) =>
      _firestore.savePlan(household.value, mealPlanToFirestore(plan));

  @override
  TaskEither<AppFailure, Unit> recordCookedMeal(HouseholdId household, String title) =>
      _firestore.recordCookedMeal(household.value, title);

  @override
  Stream<Either<AppFailure, List<WeekMeal>>> watchWeek(HouseholdId household) => _firestore
      .watchWeek(household.value)
      .map(
        (Either<AppFailure, List<WeekMealData>> result) => result.map(
          (List<WeekMealData> meals) => <WeekMeal>[
            for (final WeekMealData data in meals)
              if (firestoreToWeekMeal(data).toNullable() case final WeekMeal meal) meal,
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> planMeal(HouseholdId household, MealIdea idea) =>
      _firestore.planMeal(household.value, idea.id.value, mealIdeaToWeekMeal(idea));

  @override
  TaskEither<AppFailure, Unit> unplanMeal(HouseholdId household, MealIdeaId idea) =>
      _firestore.unplanMeal(household.value, idea.value);

  @override
  TaskEither<AppFailure, Unit> markCooked(HouseholdId household, MealIdeaId idea) =>
      _firestore.markCooked(household.value, idea.value);
}
