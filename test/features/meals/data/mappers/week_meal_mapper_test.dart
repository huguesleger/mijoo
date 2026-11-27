import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/meals/data/mappers/week_meal_mapper.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';

import '../../meals_fixtures.dart';

void main() {
  test('stores the meal of the week with its chosen servings', () {
    final data = mealIdeaToWeekMeal(mealIdea().copyWith(servings: 6));
    final read = firestoreToWeekMeal({...data, 'addedAt': Timestamp.fromDate(today), 'status': 'cooked'});
    expect(read.map((it) => it.idea.servings), some(6));
    expect(read.map((it) => it.status), some(WeekMealStatus.cooked));
    expect(read.map((it) => it.addedAt), some(today));
    expect(data['status'], 'planned');
  });

  test('ignores a meal without a readable recipe', () {
    expect(firestoreToWeekMeal({'idea': 'cassé', 'status': 'planned'}), isA<None>());
  });
}
