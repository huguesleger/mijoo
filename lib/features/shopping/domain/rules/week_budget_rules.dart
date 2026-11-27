import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_week.dart';
import 'package:mijoo/features/shopping/domain/entities/week_budget.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';

DateTime weekStart(DateTime today) =>
    DateTime(today.year, today.month, today.day).subtract(Duration(days: today.weekday - DateTime.monday));

List<Expense> expensesOfWeek(List<Expense> expenses, DateTime today) {
  final DateTime start = weekStart(today);
  final DateTime end = start.add(const Duration(days: 7));
  return expenses
      .where((Expense expense) => !expense.input.date.isBefore(start) && expense.input.date.isBefore(end))
      .toList()
    ..sort((Expense a, Expense b) => a.input.date.compareTo(b.input.date));
}

WeekBudget weekBudget(ShoppingWeek week, Option<int> budgetCents, DateTime today) => WeekBudget(
  start: weekStart(today),
  budgetCents: budgetCents,
  spentCents: expensesOfWeek(
    week.expenses,
    today,
  ).fold(0, (int total, Expense expense) => total + expense.input.amountCents),
  basket: basketEstimate(shoppingList(week.facts).lines, week.prices),
);
