import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_filter.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/entities/stores_origin.dart';
import 'package:mijoo/features/stores/domain/stores_repository.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_view.dart';

export 'package:mijoo/features/stores/presentation/bloc/stores_view.dart';

part 'package:mijoo/features/stores/presentation/bloc/stores_state.dart';

final class StoresCubit extends SafeCubit<StoresState> {
  StoresCubit({
    required Option<HouseholdLocation> town,
    StoresRepository? repository,
    Duration? minimalLoading,
    DateTime Function()? clock,
  }) : _repository = repository ?? getIt.get<StoresRepository>(),
       _minimalLoading = minimalLoading ?? MjLoader.minDuration,
       _clock = clock ?? DateTime.now,
       super(StoresLoading(town: town, choices: initialStoresChoices));

  final StoresRepository _repository;
  final Duration _minimalLoading;
  final DateTime Function() _clock;
  int _search = 0;

  Future<void> search() => _searchWith(state.choices);

  Future<void> changeRadius(StoreRadius radius) =>
      radius == state.choices.radius ? Future<void>.value() : _searchWith(_with(radius: radius));

  Future<void> usePosition() => _searchWith(_with(origin: StoresOrigin.position));

  Future<void> useTown() => _searchWith(_with(origin: StoresOrigin.town));

  void changeFilter(StoreFilter filter) => emit(state.withChoices(_with(filter: filter)));

  void changeView(StoresView view) => emit(state.withChoices(_with(view: view)));

  StoresChoices _with({StoresOrigin? origin, StoreRadius? radius, StoreFilter? filter, StoresView? view}) => (
    origin: origin ?? state.choices.origin,
    radius: radius ?? state.choices.radius,
    filter: filter ?? state.choices.filter,
    view: view ?? state.choices.view,
  );

  Future<void> _searchWith(StoresChoices choices) {
    final int search = ++_search;
    final Option<HouseholdLocation> town = state.town;
    return switch ((choices.origin, town)) {
      (StoresOrigin.town, None()) => Future<void>.sync(() => emit(StoresNoTown(town: town, choices: choices))),
      (StoresOrigin.town, Some(value: final HouseholdLocation location)) => _load(
        search,
        choices,
        _repository.locateTown(location),
      ),
      (StoresOrigin.position, _) => _load(search, choices, _repository.currentPosition()),
    };
  }

  Future<void> _load(int search, StoresChoices choices, TaskEither<AppFailure, Coordinates> center) {
    final Option<HouseholdLocation> town = state.town;
    emit(StoresLoading(town: town, choices: choices));
    return center
        .flatMap(
          (Coordinates center) => _repository
              .storesAround(center, choices.radius, remember: choices.origin == StoresOrigin.town)
              .map((List<Store> stores) => (center: center, stores: stores)),
        )
        .withMinimalDelay(_minimalLoading)
        .match<StoresState>(
          (AppFailure failure) => StoresFailed(failure, town: town, choices: state.choices),
          (({Coordinates center, List<Store> stores}) found) => StoresLoaded(
            center: found.center,
            stores: found.stores,
            now: _clock(),
            town: town,
            choices: state.choices,
          ),
        )
        .map((StoresState next) => search == _search ? emit(next) : null)
        .run();
  }
}
