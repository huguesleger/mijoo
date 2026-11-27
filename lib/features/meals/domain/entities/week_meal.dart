import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';

enum WeekMealStatus { planned, cooked }

final class WeekMeal {
  const WeekMeal({required this.idea, required this.status, required this.addedAt});

  final MealIdea idea;
  final WeekMealStatus status;
  final DateTime addedAt;
}
