import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';

part 'package:mijoo/features/fridge/presentation/bloc/fridge_state.dart';

final class FridgeCubit extends SafeCubit<FridgeState> {
  FridgeCubit({required HouseholdId household, FridgeRepository? repository, Duration? minimalLoading})
    : _household = household,
      _repository = repository ?? getIt.get<FridgeRepository>(),
      _minimalLoading = minimalLoading ?? MjSkeletonizer.minDuration,
      super(const FridgeLoading());

  final HouseholdId _household;
  final FridgeRepository _repository;
  final Duration _minimalLoading;
  StreamSubscription<Either<AppFailure, List<FridgeItem>>>? _items;

  void watch() {
    unawaited(_items?.cancel());
    emit(const FridgeLoading());
    _items = Stream<void>.fromFuture(Future<void>.delayed(_minimalLoading))
        .asyncExpand((_) => _repository.watchItems(_household))
        .listen(
          (Either<AppFailure, List<FridgeItem>> result) => emit(
            result.match<FridgeState>(
              FridgeFailed.new,
              (List<FridgeItem> items) => switch (state) {
                final FridgeLoaded loaded => loaded.copyWith(items: items),
                FridgeLoading() || FridgeFailed() => FridgeLoaded(items: items, query: '', writeFailure: none()),
              },
            ),
          ),
        );
  }

  void search(String query) => switch (state) {
    final FridgeLoaded loaded => emit(loaded.copyWith(query: query)),
    FridgeLoading() || FridgeFailed() => null,
  };

  Future<void> addItem(FridgeItemInput input) => _write(_repository.addItem(_household, input));

  Future<void> updateItem(FridgeItemId item, FridgeItemInput input) =>
      _write(_repository.updateItem(_household, item, input));

  Future<void> deleteItem(FridgeItemId item) => _write(_repository.deleteItem(_household, item));

  Future<void> _write(TaskEither<AppFailure, Unit> operation) => operation
      .match<Option<AppFailure>>(some, (_) => none())
      .map(
        (Option<AppFailure> failure) => switch (state) {
          final FridgeLoaded loaded => emit(loaded.copyWith(writeFailure: failure)),
          FridgeLoading() || FridgeFailed() => null,
        },
      )
      .run();

  @override
  Future<void> close() async {
    await _items?.cancel();
    return super.close();
  }
}
