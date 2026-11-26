import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_failure.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mocktail/mocktail.dart';

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  const HouseholdId household = HouseholdId('h1');
  final FridgeItem tomatoes = FridgeItem(
    id: const FridgeItemId('tomates'),
    name: 'Tomates',
    quantity: 4,
    unit: FridgeUnit.piece,
    category: FridgeCategory.fruitsVegetables,
    bestBefore: none(),
  );
  final FridgeItemInput input = FridgeItemInput(
    name: 'Lait',
    quantity: 1,
    unit: FridgeUnit.liter,
    category: FridgeCategory.dairy,
    bestBefore: none(),
  );
  late MockFridgeRepository repository;

  setUpAll(() => registerFallbackValue(input));
  setUp(() => repository = MockFridgeRepository());

  FridgeCubit build() => FridgeCubit(household: household, repository: repository, minimalLoading: Duration.zero);

  blocTest<FridgeCubit, FridgeState>(
    'shows the items of the household and keeps the search while they change',
    build: () {
      when(() => repository.watchItems(household)).thenAnswer(
        (_) => Stream<Either<AppFailure, List<FridgeItem>>>.fromIterable(<Either<AppFailure, List<FridgeItem>>>[
          right(<FridgeItem>[]),
          right(<FridgeItem>[tomatoes]),
        ]),
      );
      return build();
    },
    act: (FridgeCubit cubit) async {
      cubit.watch();
      await Future<void>.delayed(Duration.zero);
      cubit.search('tom');
      await Future<void>.delayed(Duration.zero);
    },
    expect: () => <Matcher>[
      isA<FridgeLoading>(),
      isA<FridgeLoaded>().having((FridgeLoaded state) => state.items, 'items', isEmpty),
      isA<FridgeLoaded>().having((FridgeLoaded state) => state.items, 'items', <FridgeItem>[tomatoes]),
      isA<FridgeLoaded>().having((FridgeLoaded state) => state.query, 'query', 'tom'),
    ],
  );

  blocTest<FridgeCubit, FridgeState>(
    'shows the failure when the fridge cannot be read',
    build: () {
      when(() => repository.watchItems(household)).thenAnswer(
        (_) => Stream<Either<AppFailure, List<FridgeItem>>>.value(left(const FridgeAccessDenied())),
      );
      return build();
    },
    act: (FridgeCubit cubit) => cubit.watch(),
    wait: Duration.zero,
    expect: () => <Matcher>[
      isA<FridgeLoading>(),
      isA<FridgeFailed>().having((FridgeFailed state) => state.failure, 'failure', const FridgeAccessDenied()),
    ],
  );

  blocTest<FridgeCubit, FridgeState>(
    'keeps the list and reports a failed write',
    build: () {
      when(() => repository.watchItems(household)).thenAnswer(
        (_) => Stream<Either<AppFailure, List<FridgeItem>>>.value(right(<FridgeItem>[tomatoes])),
      );
      when(
        () => repository.addItem(household, any()),
      ).thenReturn(TaskEither<AppFailure, Unit>.left(const FridgeNetworkFailure()));
      return build();
    },
    act: (FridgeCubit cubit) async {
      cubit.watch();
      await Future<void>.delayed(Duration.zero);
      await cubit.addItem(input);
    },
    skip: 2,
    expect: () => <Matcher>[
      isA<FridgeLoaded>()
          .having((FridgeLoaded state) => state.items, 'items', <FridgeItem>[tomatoes])
          .having((FridgeLoaded state) => state.writeFailure, 'writeFailure', some(const FridgeNetworkFailure())),
    ],
  );

  blocTest<FridgeCubit, FridgeState>(
    'deletes and updates items of the household',
    build: () {
      when(
        () => repository.deleteItem(household, tomatoes.id),
      ).thenReturn(TaskEither<AppFailure, Unit>.right(unit));
      when(
        () => repository.updateItem(household, tomatoes.id, any()),
      ).thenReturn(TaskEither<AppFailure, Unit>.right(unit));
      return build();
    },
    act: (FridgeCubit cubit) async {
      await cubit.updateItem(tomatoes.id, input);
      await cubit.deleteItem(tomatoes.id);
    },
    verify: (_) {
      verify(() => repository.updateItem(household, tomatoes.id, input)).called(1);
      verify(() => repository.deleteItem(household, tomatoes.id)).called(1);
    },
  );
}
