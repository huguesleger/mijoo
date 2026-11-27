import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/data/mappers/meal_idea_mapper.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';

void main() {
  Map<String, Object?> meal({Object? prepMinutes = 10, Object? cookMinutes = 15, Object? ingredients, Object? steps}) =>
      <String, Object?>{
        'title': 'Gratin d’épinards',
        'description': 'Un gratin fondant.',
        'prepMinutes': prepMinutes,
        'cookMinutes': cookMinutes,
        'servings': 4,
        'kind': 'oven',
        'difficulty': 'medium',
        'equipment': ['Plat à gratin', '  '],
        'ingredients':
            ingredients ??
            <Object?>[
              <String, Object?>{
                'name': 'Épinards',
                'quantity': 1,
                'unit': 'pack',
                'category': 'fruitsVegetables',
                'substitute': null,
              },
              <String, Object?>{'name': 'Gruyère', 'quantity': -3, 'unit': 'tonne', 'substitute': 'Parmesan'},
            ],
        'steps':
            steps ??
            <Object?>[
              <String, Object?>{'text': 'Fais revenir les épinards.', 'minutes': 3},
              <String, Object?>{'text': '  ', 'minutes': null},
            ],
        'photoQueries': ['spinach gratin', 'gratin', 'spinach', 'green'],
      };

  test('reads the ideas sent by Gemini and repairs odd values', () {
    final idea = geminiToMealIdeas(
      jsonEncode({
        'meals': [meal()],
      }),
    ).getOrElse(() => []).single;
    expect(idea.id.value, 'gratin-d-epinards');
    expect(idea.minutes, 25);
    expect(idea.kind, MealKind.oven);
    expect(idea.difficulty, MealDifficulty.medium);
    expect(idea.equipment, ['Plat à gratin']);
    expect(idea.steps.single.minutes, some(3));
    expect(idea.photoQueries, ['spinach gratin', 'gratin', 'spinach']);
    expect(idea.photo, isA<None>());
    expect(idea.ingredients.first.category, FridgeCategory.fruitsVegetables);
    expect(idea.ingredients.last.quantity, 1);
    expect(idea.ingredients.last.unit, FridgeUnit.piece);
    expect(idea.ingredients.last.category, FridgeCategory.other);
    expect(idea.ingredients.last.substitute, some('Parmesan'));
  });

  test('drops an idea without duration, ingredients or steps', () {
    final json = jsonEncode({
      'meals': [
        meal(prepMinutes: null, cookMinutes: null),
        meal(ingredients: []),
        meal(steps: []),
        meal(prepMinutes: 200, cookMinutes: 100),
      ],
    });
    expect(geminiToMealIdeas(json), isA<None>());
    expect(geminiToMealIdeas('pas du json'), isA<None>());
  });

  test('stores and reads back the plan of the household, photo included', () {
    final idea = geminiToMealIdeas(
      jsonEncode({
        'meals': [meal()],
      }),
    ).getOrElse(() => []).single.copyWith(photo: some(Uri.parse('https://www.themealdb.com/a.jpg')));
    final data = mealPlanToFirestore(MealPlan(ideas: [idea], craving: MealCraving.quick, createdAt: DateTime(2026)));
    final plan = firestoreToMealPlan({...data, 'createdAt': Timestamp.fromDate(DateTime(2026, 11, 27))});
    final read = plan.map((it) => it.ideas.single);
    expect(plan.map((it) => it.craving), some(MealCraving.quick));
    expect(read.map((it) => it.photo.map((photo) => photo.host)), some(some('www.themealdb.com')));
    expect(read.map((it) => it.steps.single.minutes), some(some(3)));
    expect(read.map((it) => it.difficulty), some(MealDifficulty.medium));
  });

  test('still reads an idea saved before the detail redesign', () {
    final plan = firestoreToMealPlan({
      'craving': 'any',
      'ideas': [
        {
          'id': 'gratin',
          'title': 'Gratin',
          'minutes': 25,
          'servings': 4,
          'kind': 'oven',
          'ingredients': [
            {'name': 'Épinards', 'quantity': 1, 'unit': 'pack', 'substitute': null},
          ],
          'steps': ['Enfourne.'],
        },
      ],
    });
    final idea = plan.map((it) => it.ideas.single);
    expect(idea.map((it) => it.minutes), some(25));
    expect(idea.map((it) => it.steps.single.text), some('Enfourne.'));
    expect(idea.map((it) => it.difficulty), some(MealDifficulty.easy));
  });
}
