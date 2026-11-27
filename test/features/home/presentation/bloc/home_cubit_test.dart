import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_failure.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/home/presentation/bloc/home_cubit.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mocktail/mocktail.dart';

class MockFridgeRepository extends Mock implements FridgeRepository {}

FridgeItem item(String name, Option<DateTime> bestBefore) => FridgeItem(
  id: FridgeItemId(name),
  name: name,
  quantity: 1,
  unit: FridgeUnit.piece,
  category: FridgeCategory.dairy,
  bestBefore: bestBefore,
);

void main() {
  const HouseholdId household = HouseholdId('h1');
  final DateTime today = DateTime(2026, 11, 27);
  late MockFridgeRepository repository;

  setUp(() => repository = MockFridgeRepository());

  HomeCubit build() =>
      HomeCubit(household: household, repository: repository, minimalLoading: Duration.zero, clock: () => today);

  blocTest<HomeCubit, HomeState>(
    'shows the ingredients to finish first',
    build: () {
      when(() => repository.watchItems(household)).thenAnswer(
        (_) => Stream<Either<AppFailure, List<FridgeItem>>>.value(
          right(<FridgeItem>[
            item('Riz', none()),
            item('Yaourts', some(DateTime(2026, 11, 29))),
            item('Lait', some(DateTime(2026, 11, 28))),
          ]),
        ),
      );
      return build();
    },
    act: (HomeCubit cubit) => cubit.watch(),
    wait: Duration.zero,
    expect: () => <Matcher>[
      isA<HomeLoading>(),
      isA<HomeLoaded>().having(
        (HomeLoaded state) => state.finishFirst.map((FridgeItem item) => item.name),
        'names',
        <String>['Lait', 'Yaourts'],
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'shows the failure of the fridge',
    build: () {
      when(() => repository.watchItems(household)).thenAnswer(
        (_) => Stream<Either<AppFailure, List<FridgeItem>>>.value(left(const FridgeNetworkFailure())),
      );
      return build();
    },
    act: (HomeCubit cubit) => cubit.watch(),
    wait: Duration.zero,
    expect: () => <Matcher>[
      isA<HomeLoading>(),
      isA<HomeFailed>().having((HomeFailed state) => state.failure, 'failure', const FridgeNetworkFailure()),
    ],
  );
}
