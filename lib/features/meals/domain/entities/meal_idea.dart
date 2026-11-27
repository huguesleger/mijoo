import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/domain/entities/meal_step.dart';

extension type const MealIdeaId(String value) {}

final class MealIdea {
  const MealIdea({
    required this.id,
    required this.title,
    required this.description,
    required this.prepMinutes,
    required this.cookMinutes,
    required this.servings,
    required this.kind,
    required this.difficulty,
    required this.equipment,
    required this.ingredients,
    required this.steps,
    required this.photoQueries,
    required this.photo,
  });

  final MealIdeaId id;
  final String title;
  final String description;
  final int prepMinutes;
  final int cookMinutes;
  final int servings;
  final MealKind kind;
  final MealDifficulty difficulty;
  final List<String> equipment;
  final List<MealIngredient> ingredients;
  final List<MealStep> steps;
  final List<String> photoQueries;
  final Option<Uri> photo;

  int get minutes => prepMinutes + cookMinutes;

  MealIdea copyWith({int? servings, List<MealIngredient>? ingredients, Option<Uri>? photo}) => MealIdea(
    id: id,
    title: title,
    description: description,
    prepMinutes: prepMinutes,
    cookMinutes: cookMinutes,
    servings: servings ?? this.servings,
    kind: kind,
    difficulty: difficulty,
    equipment: equipment,
    ingredients: ingredients ?? this.ingredients,
    steps: steps,
    photoQueries: photoQueries,
    photo: photo ?? this.photo,
  );
}
