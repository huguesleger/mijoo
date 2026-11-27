import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/rules/week_budget_rules.dart';
import 'package:mijoo/features/shopping/presentation/shopping_bone_mock.dart';

import '../../../meals/meals_fixtures.dart';
import '../../shopping_fixtures.dart';

Expense expense(String id, int cents, DateTime date) => Expense(
  id: ExpenseId(id),
  input: ExpenseInput(amountCents: cents, date: date, store: none(), addedBy: none()),
);

void main() {
  test('starts the week on Monday', () {
    expect(weekStart(DateTime(2026, 11, 27, 18)), DateTime(2026, 11, 23));
    expect(weekStart(DateTime(2026, 11, 23)), DateTime(2026, 11, 23));
    expect(weekStart(DateTime(2026, 11, 29, 23)), DateTime(2026, 11, 23));
  });

  test('keeps only the expenses of the current week', () {
    final expenses = [
      expense('before', 1000, DateTime(2026, 11, 22, 20)),
      expense('monday', 3240, DateTime(2026, 11, 23, 9)),
      expense('friday', 1260, DateTime(2026, 11, 27, 9)),
      expense('next', 500, DateTime(2026, 11, 30, 9)),
    ];
    expect(expensesOfWeek(expenses, today).map((it) => it.id.value), ['monday', 'friday']);
  });

  test('compares the budget to the spending and the planned basket', () {
    final budget = weekBudget(
      (
        facts: (
          week: [
            weekMeal('Velouté', [ingredient('Carottes', quantity: 2, unit: FridgeUnit.kilogram)]),
          ],
          items: [],
          entries: [],
        ),
        prices: (household: [], openPrices: {}),
        expenses: [expense('monday', 4500, DateTime(2026, 11, 23, 9))],
      ),
      some(5000),
      today,
    );
    expect(budget.start, DateTime(2026, 11, 23));
    expect(budget.spentCents, 4500);
    expect(budget.basket.cents, closeTo(300, 0.001));
    expect(budget.remainingCents.getOrElse(() => -1), closeTo(200, 0.001));
    expect(weekBudget(shoppingWeekBoneMock, none(), today).remainingCents, isA<None>());
  });
}
