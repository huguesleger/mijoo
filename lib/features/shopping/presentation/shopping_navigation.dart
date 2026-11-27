import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/week_budget_rules.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_expense_sheet.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_line_sheet.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_sheet_result.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_store_sheet.dart';

Future<void> openShoppingLineSheet(BuildContext context, ShoppingLine line) =>
    switch (context.read<ShoppingCubit>().state) {
      final ShoppingLoaded state => _openLineSheet(context, line, state),
      ShoppingLoading() || ShoppingFailed() => Future<void>.value(),
    };

Future<void> _openLineSheet(BuildContext context, ShoppingLine line, ShoppingLoaded state) async {
  final ShoppingCubit cubit = context.read<ShoppingCubit>();
  final ShoppingLineSheetResult? result = await MjBottomSheet.show<ShoppingLineSheetResult>(
    context,
    builder: (_) => ShoppingLineSheet(line: line, book: state.week.prices, today: state.today),
  );
  await switch (result) {
    ShoppingLineSaved(:final double quantity, :final FridgeCategory category, :final Option<HouseholdPrice> price) =>
      cubit.save(line, quantity, category, price),
    ShoppingLineRemoved() => cubit.remove(line),
    null => Future<void>.value(),
  };
}

Future<void> openShoppingExpenseSheet(BuildContext context, ShoppingLoaded state) async {
  final ShoppingCubit cubit = context.read<ShoppingCubit>();
  final ShoppingExpenseResult? result = await MjBottomSheet.show<ShoppingExpenseResult>(
    context,
    builder: (_) => ShoppingExpenseSheet(
      expenses: expensesOfWeek(state.week.expenses, state.today),
      budget: weekBudget(state.week, state.budgetCents, state.today),
      today: state.today,
    ),
  );
  await switch (result) {
    ShoppingExpenseAdded(:final int amountCents, :final DateTime date, :final Option<String> store) => cubit.addExpense(
      amountCents,
      date,
      store,
    ),
    ShoppingExpenseDeleted(:final expense) => cubit.deleteExpense(expense),
    null => Future<void>.value(),
  };
}

Future<void> openShoppingStoreSheet(BuildContext context, List<ShoppingLine> checked) async {
  final ShoppingCubit cubit = context.read<ShoppingCubit>();
  final ShoppingStoreConfirmed? result = await MjBottomSheet.show<ShoppingStoreConfirmed>(
    context,
    builder: (_) => ShoppingStoreSheet(checked: checked),
  );
  if (result case final ShoppingStoreConfirmed confirmed) await cubit.store(confirmed.toFridge, checked);
}
