import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/scan/domain/rules/existing_ingredient.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_week.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_storage.dart';
import 'package:mijoo/features/shopping/domain/rules/week_budget_rules.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/shopping/domain/use_cases/watch_shopping_week.dart';

part 'package:mijoo/features/shopping/presentation/bloc/shopping_state.dart';

final class ShoppingCubit extends SafeCubit<ShoppingState> {
  ShoppingCubit({
    required HouseholdId household,
    required String author,
    required Option<int> budgetCents,
    ShoppingRepository? shopping,
    FridgeRepository? fridge,
    WatchShoppingWeek? watchWeek,
    Duration? minimalLoading,
    DateTime Function()? clock,
  }) : _household = household,
       _author = author,
       _budgetCents = budgetCents,
       _shopping = shopping ?? getIt.get<ShoppingRepository>(),
       _fridge = fridge ?? getIt.get<FridgeRepository>(),
       _watchWeek = watchWeek ?? getIt.get<WatchShoppingWeek>(),
       _minimalLoading = minimalLoading ?? MjSkeletonizer.minDuration,
       _clock = clock ?? DateTime.now,
       super(const ShoppingLoading());

  final HouseholdId _household;
  final String _author;
  final Option<int> _budgetCents;
  final ShoppingRepository _shopping;
  final FridgeRepository _fridge;
  final WatchShoppingWeek _watchWeek;
  final Duration _minimalLoading;
  final DateTime Function() _clock;
  StreamSubscription<Either<AppFailure, ShoppingWeek>>? _data;

  void watch() {
    unawaited(_data?.cancel());
    emit(const ShoppingLoading());
    _data = Stream<void>.fromFuture(Future<void>.delayed(_minimalLoading))
        .asyncExpand((_) => _watchWeek(_household, weekStart(_clock())))
        .listen(
          (Either<AppFailure, ShoppingWeek> result) => emit(
            result.match<ShoppingState>(
              ShoppingFailed.new,
              (ShoppingWeek week) => ShoppingLoaded(
                week: week,
                budgetCents: _budgetCents,
                today: _clock(),
                writeFailure: switch (state) {
                  ShoppingLoaded(:final Option<AppFailure> writeFailure) => writeFailure,
                  ShoppingLoading() || ShoppingFailed() => none(),
                },
              ),
            ),
          ),
        );
  }

  Future<void> toggle(ShoppingLine line) =>
      _write(_shopping.saveEntry(_household, line.id, lineEntry(line, checked: !line.checked)));

  Future<void> add(String name) => name.trim().isEmpty ? Future<void>.value() : _addManual(name.trim());

  Future<void> _addManual(String name) {
    final ManualDefaults defaults = manualDefaults(name);
    return _write(
      _shopping.addEntry(
        _household,
        ShoppingEntryInput(
          key: ingredientKey(name),
          name: name,
          quantity: some(defaults.quantity),
          unit: defaults.unit,
          category: defaults.category,
          checked: false,
          dismissed: false,
          manual: true,
          addedBy: some(_author),
        ),
      ),
    );
  }

  Future<void> save(ShoppingLine line, double quantity, FridgeCategory category, Option<HouseholdPrice> price) =>
      _write(
        _shopping
            .saveEntry(_household, line.id, lineEntry(line, quantity: quantity, category: category))
            .flatMap(
              (_) => price.match(
                () => TaskEither<AppFailure, Unit>.right(unit),
                (HouseholdPrice price) => _shopping.savePrice(_household, price),
              ),
            ),
      );

  Future<void> addExpense(int amountCents, DateTime date, Option<String> store) => _write(
    _shopping.addExpense(
      _household,
      ExpenseInput(amountCents: amountCents, date: date, store: store, addedBy: some(_author)),
    ),
  );

  Future<void> deleteExpense(ExpenseId expense) => _write(_shopping.deleteExpense(_household, expense));

  Future<void> remove(ShoppingLine line) => _write(
    line.manual
        ? _shopping.deleteEntries(_household, <ShoppingEntryId>[line.id])
        : _shopping.saveEntry(_household, line.id, lineEntry(line, checked: false, dismissed: true)),
  );

  Future<void> store(List<ShoppingStorage> toFridge, List<ShoppingLine> checked) => switch (state) {
    ShoppingLoaded(week: (facts: final ShoppingFacts facts, prices: _, expenses: _)) => _write(
      TaskEither.traverseListSeq<AppFailure, ShoppingStorage, Unit>(
        toFridge,
        (ShoppingStorage storage) => _storeInFridge(storageToFridgeItem(storage), facts.items),
      ).flatMap(
        (_) => _shopping.deleteEntries(_household, <ShoppingEntryId>[
          for (final ShoppingLine line in checked)
            if (line.manual || toFridge.any((ShoppingStorage storage) => storage.line.id == line.id)) line.id,
        ]),
      ),
    ),
    ShoppingLoading() || ShoppingFailed() => Future<void>.value(),
  };

  TaskEither<AppFailure, Unit> _storeInFridge(FridgeItemInput input, List<FridgeItem> items) =>
      existingIngredient(input, items).match(
        () => _fridge.addItem(_household, input),
        (FridgeItem item) => _fridge.updateItem(_household, item.id, mergeIntoExisting(item, input)),
      );

  Future<void> _write(TaskEither<AppFailure, Unit> operation) => operation
      .match<Option<AppFailure>>(some, (_) => none())
      .map(
        (Option<AppFailure> failure) => switch (state) {
          final ShoppingLoaded loaded => emit(loaded.copyWith(writeFailure: failure)),
          ShoppingLoading() || ShoppingFailed() => null,
        },
      )
      .run();

  @override
  Future<void> close() async {
    await _data?.cancel();
    return super.close();
  }
}
