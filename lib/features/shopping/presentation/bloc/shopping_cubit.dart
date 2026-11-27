import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/scan/domain/rules/existing_ingredient.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_storage.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';

part 'package:mijoo/features/shopping/presentation/bloc/shopping_state.dart';

final class ShoppingCubit extends SafeCubit<ShoppingState> {
  ShoppingCubit({
    required HouseholdId household,
    required String author,
    ShoppingRepository? shopping,
    MealsRepository? meals,
    FridgeRepository? fridge,
    Duration? minimalLoading,
  }) : _household = household,
       _author = author,
       _shopping = shopping ?? getIt.get<ShoppingRepository>(),
       _meals = meals ?? getIt.get<MealsRepository>(),
       _fridge = fridge ?? getIt.get<FridgeRepository>(),
       _minimalLoading = minimalLoading ?? MjSkeletonizer.minDuration,
       super(const ShoppingLoading());

  final HouseholdId _household;
  final String _author;
  final ShoppingRepository _shopping;
  final MealsRepository _meals;
  final FridgeRepository _fridge;
  final Duration _minimalLoading;
  StreamSubscription<Either<AppFailure, ((List<WeekMeal>, List<FridgeItem>), List<ShoppingEntry>)>>? _data;

  void watch() {
    unawaited(_data?.cancel());
    emit(const ShoppingLoading());
    _data = Stream<void>.fromFuture(Future<void>.delayed(_minimalLoading))
        .asyncExpand(
          (_) => combineLatestEither(
            combineLatestEither(_meals.watchWeek(_household), _fridge.watchItems(_household)),
            _shopping.watchEntries(_household),
          ),
        )
        .listen(
          (Either<AppFailure, ((List<WeekMeal>, List<FridgeItem>), List<ShoppingEntry>)> result) => emit(
            result.match<ShoppingState>(
              ShoppingFailed.new,
              (((List<WeekMeal>, List<FridgeItem>), List<ShoppingEntry>) data) => ShoppingLoaded(
                facts: (week: data.$1.$1, items: data.$1.$2, entries: data.$2),
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

  Future<void> add(String name) => name.trim().isEmpty
      ? Future<void>.value()
      : _write(
          _shopping.addEntry(
            _household,
            ShoppingEntryInput(
              key: ingredientKey(name),
              name: name.trim(),
              quantity: some(1),
              unit: FridgeUnit.piece,
              category: none(),
              checked: false,
              dismissed: false,
              manual: true,
              addedBy: some(_author),
            ),
          ),
        );

  Future<void> save(ShoppingLine line, double quantity, FridgeCategory category) =>
      _write(_shopping.saveEntry(_household, line.id, lineEntry(line, quantity: quantity, category: category)));

  Future<void> remove(ShoppingLine line) => _write(
    line.manual
        ? _shopping.deleteEntries(_household, <ShoppingEntryId>[line.id])
        : _shopping.saveEntry(_household, line.id, lineEntry(line, checked: false, dismissed: true)),
  );

  Future<void> store(List<ShoppingStorage> toFridge, List<ShoppingLine> checked) => switch (state) {
    ShoppingLoaded(:final ShoppingFacts facts) => _write(
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
