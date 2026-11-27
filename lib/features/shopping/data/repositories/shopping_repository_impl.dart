import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/shopping/data/data_sources/firestore_shopping_data_source.dart';
import 'package:mijoo/features/shopping/data/data_sources/open_prices_data_source.dart';
import 'package:mijoo/features/shopping/data/mappers/price_expense_mapper.dart';
import 'package:mijoo/features/shopping/data/mappers/shopping_entry_mapper.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';

final class ShoppingRepositoryImpl implements ShoppingRepository {
  const ShoppingRepositoryImpl(this._firestore, this._openPrices);

  final FirestoreShoppingDataSource _firestore;
  final OpenPricesDataSource _openPrices;

  @override
  Stream<Either<AppFailure, List<ShoppingEntry>>> watchEntries(HouseholdId household) => _firestore
      .watchEntries(household.value)
      .map(
        (Either<AppFailure, List<ShoppingEntrySnapshot>> result) => result.map(
          (List<ShoppingEntrySnapshot> entries) => <ShoppingEntry>[
            for (final ShoppingEntrySnapshot entry in entries)
              if (firestoreToShoppingEntry(entry.id, entry.data).toNullable() case final ShoppingEntry parsed) parsed,
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> addEntry(HouseholdId household, ShoppingEntryInput input) =>
      _firestore.addEntry(household.value, shoppingEntryToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> saveEntry(HouseholdId household, ShoppingEntryId entry, ShoppingEntryInput input) =>
      _firestore.saveEntry(household.value, entry.value, shoppingEntryToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> deleteEntries(HouseholdId household, List<ShoppingEntryId> entries) =>
      _firestore.deleteEntries(household.value, <String>[for (final ShoppingEntryId entry in entries) entry.value]);

  @override
  Stream<Either<AppFailure, List<HouseholdPrice>>> watchPrices(HouseholdId household) => _firestore
      .watchPrices(household.value)
      .map(
        (Either<AppFailure, List<({String id, Map<String, Object?> data})>> result) => result.map(
          (List<({String id, Map<String, Object?> data})> prices) => <HouseholdPrice>[
            for (final ({String id, Map<String, Object?> data}) price in prices)
              if (firestoreToHouseholdPrice(price.data).toNullable() case final HouseholdPrice parsed) parsed,
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> savePrice(HouseholdId household, HouseholdPrice price) => _firestore.savePrice(
    household.value,
    householdPriceDocument(price.key),
    householdPriceToFirestore(price),
  );

  @override
  Task<Map<String, OpenPriceStats>> openPrices(Map<String, PriceBasis> tags) =>
      Task.traverseList(
        tags.entries.toList(),
        (MapEntry<String, PriceBasis> tag) => _openPrices.stats(tag.key, tag.value),
      ).map(
        (List<Option<OpenPriceStats>> stats) => <String, OpenPriceStats>{
          for (final Option<OpenPriceStats> found in stats)
            if (found.toNullable() case final OpenPriceStats value) value.tag: value,
        },
      );

  @override
  Stream<Either<AppFailure, List<Expense>>> watchExpenses(HouseholdId household, DateTime since) => _firestore
      .watchExpenses(household.value, since)
      .map(
        (Either<AppFailure, List<({String id, Map<String, Object?> data})>> result) => result.map(
          (List<({String id, Map<String, Object?> data})> expenses) => <Expense>[
            for (final ({String id, Map<String, Object?> data}) expense in expenses)
              if (firestoreToExpense(expense.id, expense.data).toNullable() case final Expense parsed) parsed,
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> addExpense(HouseholdId household, ExpenseInput input) =>
      _firestore.addExpense(household.value, expenseToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> deleteExpense(HouseholdId household, ExpenseId expense) =>
      _firestore.deleteExpense(household.value, expense.value);
}
