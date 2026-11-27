import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/domain/rules/ingredient_names.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/meal_step.dart';

typedef MealPlanData = Map<String, Object?>;

const int maxMealTitleLength = 80;
const int maxMealDescriptionLength = 200;
const int maxMealTextLength = 300;
const int maxMealIngredients = 20;
const int maxMealSteps = 12;
const int maxMealEquipment = 4;
const int maxMealMinutes = 240;
const int maxPhotoQueries = 3;

Option<List<MealIdea>> geminiToMealIdeas(String json) => _decode(json)
    .flatMap(
      (Map<String, Object?> data) => switch (data['meals']) {
        final List<Object?> meals => some(_ideas(meals)),
        _ => none<List<MealIdea>>(),
      },
    )
    .filter((List<MealIdea> ideas) => ideas.isNotEmpty);

Option<MealPlan> firestoreToMealPlan(MealPlanData data) => switch (data['ideas']) {
  final List<Object?> ideas => some(
    MealPlan(
      ideas: _ideas(ideas),
      craving: _byName(MealCraving.values, data['craving']).getOrElse(() => MealCraving.any),
      createdAt: switch (data['createdAt']) {
        final Timestamp timestamp => timestamp.toDate(),
        _ => DateTime.fromMillisecondsSinceEpoch(0),
      },
    ),
  ),
  _ => none(),
};

MealPlanData mealPlanToFirestore(MealPlan plan) => <String, Object?>{
  'craving': plan.craving.name,
  'ideas': <Map<String, Object?>>[for (final MealIdea idea in plan.ideas) mealIdeaToFirestore(idea)],
};

Map<String, Object?> mealIdeaToFirestore(MealIdea idea) => <String, Object?>{
  'id': idea.id.value,
  'title': idea.title,
  'description': idea.description,
  'prepMinutes': idea.prepMinutes,
  'cookMinutes': idea.cookMinutes,
  'servings': idea.servings,
  'kind': idea.kind.name,
  'difficulty': idea.difficulty.name,
  'equipment': idea.equipment,
  'photo': idea.photo.map((Uri photo) => photo.toString()).toNullable(),
  'ingredients': <Map<String, Object?>>[
    for (final MealIngredient ingredient in idea.ingredients)
      <String, Object?>{
        'name': ingredient.name,
        'quantity': ingredient.quantity,
        'unit': ingredient.unit.name,
        'category': ingredient.category.name,
        'substitute': ingredient.substitute.toNullable(),
      },
  ],
  'steps': <Map<String, Object?>>[
    for (final MealStep step in idea.steps) <String, Object?>{'text': step.text, 'minutes': step.minutes.toNullable()},
  ],
};

Option<MealIdea> firestoreToMealIdea(Object? data) => switch (data) {
  final Map<String, Object?> map => _idea(map),
  _ => none(),
};

List<MealIdea> _ideas(List<Object?> list) => <MealIdea>[
  for (final Object? meal in list)
    if (meal case final Map<String, Object?> data)
      if (_idea(data).toNullable() case final MealIdea idea) idea,
];

Option<MealIdea> _idea(Map<String, Object?> data) {
  final List<MealIngredient> ingredients = <MealIngredient>[
    for (final Object? ingredient in _list(data['ingredients']).take(maxMealIngredients))
      if (ingredient case final Map<String, Object?> value)
        if (_ingredient(value).toNullable() case final MealIngredient parsed) parsed,
  ];
  final List<MealStep> steps = <MealStep>[
    for (final Object? step in _list(data['steps']).take(maxMealSteps))
      if (_step(step).toNullable() case final MealStep parsed) parsed,
  ];
  final Option<int> legacyMinutes = _minutes(data['minutes']);
  final int prepMinutes = _minutes(data['prepMinutes']).alt(() => legacyMinutes).getOrElse(() => 0);
  final int cookMinutes = _minutes(data['cookMinutes']).getOrElse(() => 0);
  return switch (_text(data['title'], maxMealTitleLength)) {
    Some(value: final String title)
        when prepMinutes + cookMinutes > 0 &&
            prepMinutes + cookMinutes <= maxMealMinutes &&
            ingredients.isNotEmpty &&
            steps.isNotEmpty =>
      some(
        MealIdea(
          id: switch (data['id']) {
            final String id when id.isNotEmpty => MealIdeaId(id),
            _ => MealIdeaId(normalizeIngredientName(title).replaceAll(RegExp('[^a-z0-9]+'), '-')),
          },
          title: title,
          description: _text(data['description'], maxMealDescriptionLength).getOrElse(() => ''),
          prepMinutes: prepMinutes,
          cookMinutes: cookMinutes,
          servings: switch (data['servings']) {
            final num servings when servings >= 1 && servings <= 24 => servings.round(),
            _ => 1,
          },
          kind: _byName(MealKind.values, data['kind']).getOrElse(() => MealKind.other),
          difficulty: _byName(MealDifficulty.values, data['difficulty']).getOrElse(() => MealDifficulty.easy),
          equipment: _texts(data['equipment'], maxMealEquipment, maxMealTitleLength),
          ingredients: ingredients,
          steps: steps,
          photoQueries: _texts(data['photoQueries'], maxPhotoQueries, maxMealTitleLength),
          photo: _text(data['photo'], maxMealTextLength).flatMap(
            (String photo) => Option<Uri>.fromNullable(Uri.tryParse(photo)).filter((Uri uri) => uri.isScheme('https')),
          ),
        ),
      ),
    _ => none(),
  };
}

Option<MealIngredient> _ingredient(Map<String, Object?> data) => _text(data['name'], maxMealTitleLength).map(
  (String name) => MealIngredient(
    name: name,
    quantity: switch (data['quantity']) {
      final num quantity when quantity > 0 && quantity <= maxFridgeQuantity => quantity.toDouble(),
      _ => 1,
    },
    unit: _byName(FridgeUnit.values, data['unit']).getOrElse(() => FridgeUnit.piece),
    category: _byName(FridgeCategory.values, data['category']).getOrElse(() => FridgeCategory.other),
    substitute: _text(data['substitute'], maxMealTitleLength),
  ),
);

Option<MealStep> _step(Object? data) => switch (data) {
  final String text => _text(text, maxMealTextLength).map((String text) => MealStep(text: text, minutes: none())),
  {'text': final Object? text} => _text(
    text,
    maxMealTextLength,
  ).map((String text) => MealStep(text: text, minutes: _minutes(data['minutes']))),
  _ => none(),
};

Option<int> _minutes(Object? value) => switch (value) {
  final num minutes when minutes >= 0 && minutes <= maxMealMinutes => some(minutes.round()),
  _ => none(),
};

List<Object?> _list(Object? value) => switch (value) {
  final List<Object?> list => list,
  _ => const <Object?>[],
};

List<String> _texts(Object? value, int maxCount, int maxLength) => <String>[
  for (final Object? text in _list(value))
    if (_text(text, maxLength).toNullable() case final String parsed) parsed,
].take(maxCount).toList();

Option<String> _text(Object? value, int maxLength) => switch (value) {
  final String text when text.trim().isNotEmpty => some(_shorten(text.trim(), maxLength)),
  _ => none(),
};

String _shorten(String text, int maxLength) => text.length > maxLength ? text.substring(0, maxLength).trim() : text;

Option<Map<String, Object?>> _decode(String json) => Option<Object?>.tryCatch(() => jsonDecode(json)).flatMap(
  (Object? data) => switch (data) {
    final Map<String, Object?> map => some(map),
    _ => none(),
  },
);

Option<T> _byName<T extends Enum>(List<T> values, Object? name) =>
    Option<T>.fromNullable(values.where((T value) => value.name == name).firstOrNull);
