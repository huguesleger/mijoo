import 'package:fpdart/fpdart.dart';

extension type const ExpenseId(String value) {}

final class ExpenseInput {
  const ExpenseInput({required this.amountCents, required this.date, required this.store, required this.addedBy});

  final int amountCents;
  final DateTime date;
  final Option<String> store;
  final Option<String> addedBy;
}

final class Expense {
  const Expense({required this.id, required this.input});

  final ExpenseId id;
  final ExpenseInput input;
}
