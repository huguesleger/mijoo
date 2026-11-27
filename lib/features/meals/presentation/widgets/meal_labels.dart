import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';

String mealDifficultyLabel(MealDifficulty difficulty) => t.meals.difficulties[difficulty.name] ?? difficulty.name;
