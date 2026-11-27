import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';

abstract interface class ShoppingRepository {
  Stream<Either<AppFailure, List<ShoppingEntry>>> watchEntries(HouseholdId household);
  TaskEither<AppFailure, Unit> addEntry(HouseholdId household, ShoppingEntryInput input);
  TaskEither<AppFailure, Unit> saveEntry(HouseholdId household, ShoppingEntryId entry, ShoppingEntryInput input);
  TaskEither<AppFailure, Unit> deleteEntries(HouseholdId household, List<ShoppingEntryId> entries);
  Stream<Either<AppFailure, List<HouseholdPrice>>> watchPrices(HouseholdId household);
  TaskEither<AppFailure, Unit> savePrice(HouseholdId household, HouseholdPrice price);
  Task<Map<String, OpenPriceStats>> openPrices(Map<String, PriceBasis> tags);
  Stream<Either<AppFailure, List<Expense>>> watchExpenses(HouseholdId household, DateTime since);
  TaskEither<AppFailure, Unit> addExpense(HouseholdId household, ExpenseInput input);
  TaskEither<AppFailure, Unit> deleteExpense(HouseholdId household, ExpenseId expense);
}
