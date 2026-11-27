import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/fridge_failure.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/meal_request.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/shopping/domain/use_cases/watch_shopping_week.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shopping/shopping_fixtures.dart';
import '../../meals_fixtures.dart';

class MockMealsRepository extends Mock implements MealsRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  const household = HouseholdId('h1');
  late MockMealsRepository meals;
  late MockFridgeRepository fridge;
  late MockShoppingRepository shopping;

  setUpAll(() {
    registerFallbackValue(household);
    registerShoppingFallbacks();
    registerFallbackValue(<String>[]);
    registerFallbackValue(MealPlan(ideas: const [], craving: MealCraving.any, createdAt: today));
    registerFallbackValue(
      const MealRequest(profile: profile, items: [], toFinishFirst: [], craving: MealCraving.any, recentTitles: []),
    );
  });

  setUp(() {
    meals = MockMealsRepository();
    fridge = MockFridgeRepository();
    when(() => meals.watchPlan(household)).thenAnswer((_) => Stream.value(right(none())));
    when(() => meals.watchWeek(household)).thenAnswer((_) => Stream.value(right(const [])));
    when(() => fridge.watchItems(household)).thenAnswer((_) => Stream.value(right([fridgeItem('Oeufs')])));
    when(() => meals.recentMealTitles(household)).thenReturn(TaskEither.right(['Pâtes au pesto']));
    when(() => meals.savePlan(household, any())).thenReturn(TaskEither.right(unit));
    when(() => meals.findPhoto(any())).thenReturn(Task.of(none()));
    shopping = MockShoppingRepository();
    when(() => shopping.watchEntries(household)).thenAnswer((_) => Stream.value(right(const [])));
    stubPricesAndExpenses(shopping, household);
  });

  MealsCubit build() => MealsCubit(
    household: household,
    profile: profile,
    meals: meals,
    watchWeek: WatchShoppingWeek(shopping: shopping, meals: meals, fridge: fridge),
    minimalLoading: Duration.zero,
    clock: () => today,
  );

  blocTest<MealsCubit, MealsState>(
    'shows the fridge and the absence of ideas',
    build: build,
    act: (cubit) => cubit.watch(),
    wait: Duration.zero,
    expect: () => [
      isA<MealsLoading>(),
      isA<MealsLoaded>()
          .having((state) => state.plan, 'plan', none<MealPlan>())
          .having((state) => state.items.length, 'items', 1),
    ],
  );

  blocTest<MealsCubit, MealsState>(
    'shows the failure of the fridge',
    build: () {
      when(() => fridge.watchItems(household)).thenAnswer((_) => Stream.value(left(const FridgeNetworkFailure())));
      return build();
    },
    act: (cubit) => cubit.watch(),
    wait: Duration.zero,
    expect: () => containsAllInOrder(<Matcher>[isA<MealsLoading>(), isA<MealsFailed>()]),
    verify: (cubit) => expect(cubit.state, isA<MealsFailed>()),
  );

  blocTest<MealsCubit, MealsState>(
    'saves only the ideas that respect the household',
    build: () {
      when(() => meals.suggest(any())).thenReturn(
        TaskEither.right([mealIdea(title: 'Quiche au jambon'), mealIdea(title: 'Gratin'), mealIdea(minutes: 90)]),
      );
      when(
        () => meals.findPhoto(['spinach gratin', 'gratin', 'spinach']),
      ).thenReturn(Task.of(some(Uri.parse('https://www.themealdb.com/gratin.jpg'))));
      return build();
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.choose(MealCraving.comforting);
    },
    skip: 2,
    expect: () => [
      isA<MealsLoaded>()
          .having((state) => state.generation, 'generation', isA<MealsGenerating>())
          .having((state) => state.craving, 'craving', MealCraving.comforting),
      isA<MealsLoaded>().having((state) => state.generation, 'generation', isA<MealsIdle>()),
    ],
    verify: (_) {
      final request = verify(() => meals.suggest(captureAny())).captured.single as MealRequest;
      expect(request.recentTitles, ['Pâtes au pesto']);
      expect(request.craving, MealCraving.comforting);
      final plan = verify(() => meals.savePlan(household, captureAny())).captured.single as MealPlan;
      expect(plan.ideas.map((it) => it.title), ['Gratin']);
      expect(plan.ideas.single.photo.map((it) => it.path), some('/gratin.jpg'));
      expect(plan.craving, MealCraving.comforting);
    },
  );

  blocTest<MealsCubit, MealsState>(
    'says so when no idea respects the household',
    build: () {
      when(() => meals.suggest(any())).thenReturn(TaskEither.right([mealIdea(title: 'Rôti de porc')]));
      return build();
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.generate();
    },
    skip: 3,
    expect: () => [
      isA<MealsLoaded>().having(
        (state) => state.generation,
        'generation',
        isA<MealsGenerationFailed>().having((it) => it.failure, 'failure', const MealsNothingSuitable()),
      ),
    ],
    verify: (_) => verifyNever(() => meals.savePlan(any(), any())),
  );

  blocTest<MealsCubit, MealsState>(
    'still suggests when the history cannot be read',
    build: () {
      when(() => meals.recentMealTitles(household)).thenReturn(TaskEither.left(const MealsNetworkFailure()));
      when(() => meals.suggest(any())).thenReturn(TaskEither.left(const MealsQuotaReached()));
      return build();
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.generate();
    },
    skip: 3,
    expect: () => [
      isA<MealsLoaded>().having(
        (state) => state.generation,
        'generation',
        isA<MealsGenerationFailed>().having((it) => it.failure, 'failure', const MealsQuotaReached()),
      ),
    ],
    verify: (_) => verify(() => meals.suggest(any())).called(1),
  );
}
