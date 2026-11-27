import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_storage.dart';

@immutable
sealed class ShoppingLineSheetResult {
  const ShoppingLineSheetResult();
}

final class ShoppingLineSaved extends ShoppingLineSheetResult {
  const ShoppingLineSaved(this.quantity, this.category, this.price);

  final double quantity;
  final FridgeCategory category;
  final Option<HouseholdPrice> price;
}

final class ShoppingLineRemoved extends ShoppingLineSheetResult {
  const ShoppingLineRemoved();
}

final class ShoppingStoreConfirmed {
  const ShoppingStoreConfirmed(this.toFridge);

  final List<ShoppingStorage> toFridge;
}

@immutable
sealed class ShoppingExpenseResult {
  const ShoppingExpenseResult();
}

final class ShoppingExpenseAdded extends ShoppingExpenseResult {
  const ShoppingExpenseAdded({required this.amountCents, required this.date, required this.store});

  final int amountCents;
  final DateTime date;
  final Option<String> store;
}

final class ShoppingExpenseDeleted extends ShoppingExpenseResult {
  const ShoppingExpenseDeleted(this.expense);

  final ExpenseId expense;
}
