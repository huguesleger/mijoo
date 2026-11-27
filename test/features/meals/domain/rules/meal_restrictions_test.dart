import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/rules/meal_restrictions.dart';

import '../../meals_fixtures.dart';

void main() {
  test('rejects an excluded or allergenic ingredient, even in the title', () {
    expect(respectsHousehold(mealIdea(), profile), isTrue);
    expect(respectsHousehold(mealIdea(ingredients: [ingredient('Lardons fumés')]), profile), isFalse);
    expect(respectsHousehold(mealIdea(ingredients: [ingredient('Cacahuètes grillées')]), profile), isFalse);
    expect(respectsHousehold(mealIdea(title: 'Quiche au jambon'), profile), isFalse);
    expect(
      respectsHousehold(mealIdea(ingredients: [ingredient('Dés de dinde', substitute: some('lardons'))]), profile),
      isFalse,
    );
  });

  test('rejects a meal longer than the household allows', () {
    expect(respectsHousehold(mealIdea(minutes: 45), profile), isFalse);
  });

  test('applies the craving of the evening', () {
    expect(matchesCraving(mealIdea(minutes: 25), MealCraving.quick), isFalse);
    expect(matchesCraving(mealIdea(minutes: 15), MealCraving.quick), isTrue);
    expect(matchesCraving(mealIdea(ingredients: [ingredient('Filet de saumon')]), MealCraving.vegetarian), isFalse);
    expect(matchesCraving(mealIdea(), MealCraving.vegetarian), isTrue);
  });

  test('keeps at most three suitable ideas', () {
    final ideas = [
      mealIdea(title: 'Un'),
      mealIdea(title: 'Porc au caramel'),
      mealIdea(title: 'Deux'),
      mealIdea(title: 'Trois'),
      mealIdea(title: 'Quatre'),
    ];
    expect(suitableIdeas(ideas, profile, MealCraving.any).map((it) => it.title), ['Un', 'Deux', 'Trois']);
  });
}
