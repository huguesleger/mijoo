import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';

final class MealPlan {
  const MealPlan({required this.ideas, required this.craving, required this.createdAt});

  final List<MealIdea> ideas;
  final MealCraving craving;
  final DateTime createdAt;

  Option<MealIdea> idea(MealIdeaId id) => Option<MealIdea>.fromNullable(
    ideas.where((MealIdea idea) => idea.id == id).firstOrNull,
  );
}
