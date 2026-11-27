import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/domain/entities/store_filter.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/entities/stores_origin.dart';
import 'package:mijoo/features/stores/domain/stores_failure.dart';
import 'package:mijoo/features/stores/domain/stores_repository.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../stores_fixtures.dart';

class MockStoresRepository extends Mock implements StoresRepository {}

void main() {
  const town = HouseholdLocation(postalCode: '69001', city: 'Lyon');
  late MockStoresRepository repository;

  setUpAll(() {
    registerFallbackValue(town);
    registerFallbackValue(lyon);
    registerFallbackValue(StoreRadius.near);
  });

  setUp(() {
    repository = MockStoresRepository();
    when(() => repository.locateTown(any())).thenReturn(TaskEither.right(lyon));
    when(
      () => repository.storesAround(any(), any(), remember: any(named: 'remember')),
    ).thenReturn(TaskEither.right([store('Monoprix')]));
  });

  StoresCubit build({Option<HouseholdLocation> household = const Some(town)}) => StoresCubit(
    town: household,
    repository: repository,
    minimalLoading: Duration.zero,
    clock: () => DateTime(2026, 11, 27, 10),
  );

  test('searches around the town of the household', () async {
    final cubit = build();
    await cubit.search();
    expect(cubit.state, isA<StoresLoaded>().having((it) => it.stores.length, 'stores', 1));
    verify(() => repository.locateTown(town)).called(1);
    verify(() => repository.storesAround(lyon, StoreRadius.near, remember: true)).called(1);
    await cubit.close();
  });

  test('asks where to search when the household has no town', () async {
    final cubit = build(household: none());
    await cubit.search();
    expect(cubit.state, isA<StoresNoTown>());
    verifyNever(() => repository.storesAround(any(), any(), remember: any(named: 'remember')));
    await cubit.close();
  });

  test('searches again with a wider radius, but filters without searching', () async {
    final cubit = build();
    await cubit.search();
    await cubit.changeRadius(StoreRadius.far);
    cubit.changeFilter(StoreFilter.bakeries);
    verify(() => repository.storesAround(lyon, StoreRadius.far, remember: true)).called(1);
    expect(cubit.state, isA<StoresLoaded>());
    expect(cubit.state.choices.filter, StoreFilter.bakeries);
    expect(cubit.state.choices.radius, StoreRadius.far);
    await cubit.close();
  });

  test('searches around the position on request and reports a refusal', () async {
    when(() => repository.currentPosition()).thenReturn(TaskEither.left(const StoresLocationDenied()));
    final cubit = build();
    await cubit.search();
    await cubit.usePosition();
    expect(cubit.state, isA<StoresFailed>().having((it) => it.failure, 'failure', const StoresLocationDenied()));
    expect(cubit.state.choices.origin, StoresOrigin.position);
    await cubit.useTown();
    expect(cubit.state, isA<StoresLoaded>());
    await cubit.close();
  });

  test('keeps only the latest search', () async {
    when(() => repository.storesAround(lyon, StoreRadius.near, remember: true)).thenReturn(
      TaskEither(() => Future.delayed(const Duration(milliseconds: 20), () => right([store('Ancien')]))),
    );
    when(
      () => repository.storesAround(lyon, StoreRadius.far, remember: true),
    ).thenReturn(TaskEither.right([store('Récent')]));
    final cubit = build();
    final first = cubit.search();
    await cubit.changeRadius(StoreRadius.far);
    await first;
    expect(
      cubit.state,
      isA<StoresLoaded>().having((it) => it.stores.single.name, 'name', some('Récent')),
    );
    await cubit.close();
  });
}
