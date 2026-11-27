part of 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';

typedef StoresChoices = ({StoresOrigin origin, StoreRadius radius, StoreFilter filter, StoresView view});

const StoresChoices initialStoresChoices = (
  origin: StoresOrigin.town,
  radius: StoreRadius.near,
  filter: StoreFilter.all,
  view: StoresView.list,
);

@immutable
sealed class StoresState {
  const StoresState({required this.town, required this.choices});

  final Option<HouseholdLocation> town;
  final StoresChoices choices;

  StoresState withChoices(StoresChoices choices);
}

final class StoresNoTown extends StoresState {
  const StoresNoTown({required super.town, required super.choices});

  @override
  StoresNoTown withChoices(StoresChoices choices) => StoresNoTown(town: town, choices: choices);
}

final class StoresLoading extends StoresState {
  const StoresLoading({required super.town, required super.choices});

  @override
  StoresLoading withChoices(StoresChoices choices) => StoresLoading(town: town, choices: choices);
}

final class StoresLoaded extends StoresState {
  const StoresLoaded({
    required this.center,
    required this.stores,
    required this.now,
    required super.town,
    required super.choices,
  });

  final Coordinates center;
  final List<Store> stores;
  final DateTime now;

  @override
  StoresLoaded withChoices(StoresChoices choices) =>
      StoresLoaded(center: center, stores: stores, now: now, town: town, choices: choices);
}

final class StoresFailed extends StoresState {
  const StoresFailed(this.failure, {required super.town, required super.choices});

  final AppFailure failure;

  @override
  StoresFailed withChoices(StoresChoices choices) => StoresFailed(failure, town: town, choices: choices);
}
