import 'package:firebase_ai/firebase_ai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/gemini_generator.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';

final class GeminiMealsDataSource {
  GeminiMealsDataSource(this._gemini);

  static const double temperature = 0.8;

  final GeminiGenerator _gemini;

  TaskEither<AppFailure, String> suggest(String prompt) => _gemini
      .generate(<Part>[TextPart(prompt)], _schema, logName: 'mijoo.meals', temperature: temperature)
      .mapLeft(
        (GeminiError error) => switch (error) {
          GeminiError.busy => const MealsBusy(),
          GeminiError.quotaReached => const MealsQuotaReached(),
          GeminiError.unavailable => const MealsUnavailable(),
          GeminiError.network => const MealsNetworkFailure(),
        },
      );

  static final Schema _schema = Schema.object(
    properties: <String, Schema>{
      'meals': Schema.array(
        items: Schema.object(
          properties: <String, Schema>{
            'title': Schema.string(),
            'description': Schema.string(),
            'prepMinutes': Schema.integer(),
            'cookMinutes': Schema.integer(),
            'servings': Schema.integer(),
            'kind': Schema.enumString(enumValues: <String>[for (final MealKind kind in MealKind.values) kind.name]),
            'difficulty': Schema.enumString(
              enumValues: <String>[for (final MealDifficulty difficulty in MealDifficulty.values) difficulty.name],
            ),
            'equipment': Schema.array(items: Schema.string()),
            'ingredients': Schema.array(
              items: Schema.object(
                properties: <String, Schema>{
                  'name': Schema.string(),
                  'quantity': Schema.number(),
                  'unit': Schema.enumString(
                    enumValues: <String>[for (final FridgeUnit unit in FridgeUnit.values) unit.name],
                  ),
                  'category': Schema.enumString(
                    enumValues: <String>[for (final FridgeCategory category in FridgeCategory.values) category.name],
                  ),
                  'substitute': Schema.string(nullable: true),
                },
              ),
            ),
            'steps': Schema.array(
              items: Schema.object(
                properties: <String, Schema>{'text': Schema.string(), 'minutes': Schema.integer(nullable: true)},
              ),
            ),
            'photoQueries': Schema.array(items: Schema.string()),
          },
        ),
      ),
    },
  );
}
