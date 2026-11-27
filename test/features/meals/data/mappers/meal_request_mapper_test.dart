import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/meals/data/mappers/meal_request_mapper.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_request.dart';

import '../../meals_fixtures.dart';

void main() {
  test('gives Gemini the household, the fridge and what to avoid', () {
    final spinach = fridgeItem('Épinards', bestBefore: some(DateTime(2026, 11, 28)));
    final prompt = mealRequestToPrompt(
      MealRequest(
        profile: profile,
        items: [spinach, fridgeItem('Oeufs', quantity: 6)],
        toFinishFirst: [spinach],
        craving: MealCraving.vegetarian,
        recentTitles: ['Pâtes au pesto'],
      ),
    );
    expect(prompt, contains('4 personnes'));
    expect(prompt, contains('30 minutes'));
    expect(prompt, contains('pork, peanuts'));
    expect(prompt, contains('- Épinards : 1 piece (à consommer avant le 28/11)'));
    expect(prompt, contains('- Oeufs : 6 piece'));
    expect(prompt, contains('À utiliser en priorité, car ils périment bientôt : Épinards.'));
    expect(prompt, contains('végétarien'));
    expect(prompt, contains('Pâtes au pesto'));
  });
}
