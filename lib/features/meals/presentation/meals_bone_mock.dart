import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/domain/entities/meal_step.dart';

final List<MealIdea> mealsBoneMock = <MealIdea>[
  for (final int index in <int>[0, 1, 2])
    MealIdea(
      id: MealIdeaId('bone-$index'),
      title: 'Idée de repas avec le frigo',
      description: '',
      prepMinutes: 10,
      cookMinutes: 15,
      servings: 4,
      kind: MealKind.other,
      difficulty: MealDifficulty.easy,
      equipment: const <String>[],
      ingredients: <MealIngredient>[
        MealIngredient(
          name: 'Ingrédient',
          quantity: 1,
          unit: FridgeUnit.piece,
          category: FridgeCategory.other,
          substitute: none(),
        ),
      ],
      steps: <MealStep>[MealStep(text: 'Étape', minutes: none())],
      photoQueries: const <String>[],
      photo: none(),
    ),
];
