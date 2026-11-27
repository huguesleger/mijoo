import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';

part 'package:mijoo/features/home/presentation/bloc/home_state.dart';

final class HomeCubit extends SafeCubit<HomeState> {
  HomeCubit({
    required HouseholdId household,
    FridgeRepository? repository,
    Duration? minimalLoading,
    DateTime Function()? clock,
  }) : _household = household,
       _repository = repository ?? getIt.get<FridgeRepository>(),
       _minimalLoading = minimalLoading ?? MjSkeletonizer.minDuration,
       _clock = clock ?? DateTime.now,
       super(const HomeLoading());

  final HouseholdId _household;
  final FridgeRepository _repository;
  final Duration _minimalLoading;
  final DateTime Function() _clock;
  StreamSubscription<Either<AppFailure, List<FridgeItem>>>? _items;

  void watch() {
    unawaited(_items?.cancel());
    emit(const HomeLoading());
    _items = Stream<void>.fromFuture(Future<void>.delayed(_minimalLoading))
        .asyncExpand((_) => _repository.watchItems(_household))
        .listen(
          (Either<AppFailure, List<FridgeItem>> result) => emit(
            result.match<HomeState>(HomeFailed.new, (List<FridgeItem> items) {
              final DateTime today = _clock();
              return HomeLoaded(finishFirst: itemsToFinishFirst(items, today), today: today);
            }),
          ),
        );
  }

  @override
  Future<void> close() async {
    await _items?.cancel();
    return super.close();
  }
}
