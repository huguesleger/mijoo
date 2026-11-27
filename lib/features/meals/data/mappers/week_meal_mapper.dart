import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/meals/data/mappers/meal_idea_mapper.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';

typedef WeekMealData = Map<String, Object?>;

Option<WeekMeal> firestoreToWeekMeal(WeekMealData data) => firestoreToMealIdea(data['idea']).map(
  (MealIdea idea) => WeekMeal(
    idea: idea,
    status: switch (data['status']) {
      'cooked' => WeekMealStatus.cooked,
      _ => WeekMealStatus.planned,
    },
    addedAt: switch (data['addedAt']) {
      final Timestamp timestamp => timestamp.toDate(),
      _ => DateTime.now(),
    },
  ),
);

WeekMealData mealIdeaToWeekMeal(MealIdea idea) => <String, Object?>{
  'idea': mealIdeaToFirestore(idea),
  'status': WeekMealStatus.planned.name,
};
