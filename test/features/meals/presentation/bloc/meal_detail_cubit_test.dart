import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/fridge_failure.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../meals_fixtures.dart';

class MockMealsRepository extends Mock implements MealsRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  const household = HouseholdId('h1');
  final idea = mealIdea();
  final eggs = fridgeItem('Oeufs', quantity: 6);
  final spinach = fridgeItem('Épinards');
  late MockMealsRepository meals;
  late MockFridgeRepository fridge;

  setUpAll(() {
    registerFallbackValue(household);
    registerFallbackValue(const FridgeItemId('x'));
    registerFallbackValue(eggs.input);
    registerFallbackValue(idea);
  });

  setUp(() {
    meals = MockMealsRepository();
    fridge = MockFridgeRepository();
    when(() => meals.watchPlan(household)).thenAnswer(
      (_) => Stream.value(right(some(MealPlan(ideas: [idea], craving: MealCraving.any, createdAt: today)))),
    );
    when(() => meals.watchWeek(household)).thenAnswer((_) => Stream.value(right(const [])));
    when(() => fridge.watchItems(household)).thenAnswer((_) => Stream.value(right([eggs, spinach])));
    when(() => fridge.updateItem(household, any(), any())).thenReturn(TaskEither.right(unit));
    when(() => fridge.deleteItem(household, any())).thenReturn(TaskEither.right(unit));
    when(() => meals.recordCookedMeal(household, any())).thenReturn(TaskEither.right(unit));
  });

  MealDetailCubit build(MealIdeaId id) => MealDetailCubit(
    household: household,
    profile: profile,
    idea: id,
    meals: meals,
    fridge: fridge,
    minimalLoading: Duration.zero,
    clock: () => today,
  );

  blocTest<MealDetailCubit, MealDetailState>(
    'says when the idea is no longer proposed',
    build: () => build(const MealIdeaId('ancienne-idee')),
    act: (cubit) => cubit.watch(),
    expect: () => [isA<MealDetailLoading>(), isA<MealDetailMissing>()],
  );

  blocTest<MealDetailCubit, MealDetailState>(
    'removes the confirmed quantities, then records the meal',
    build: () => build(idea.id),
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.cook([MealDeduction(item: eggs, quantity: 4), MealDeduction(item: spinach, quantity: 1)]);
    },
    skip: 2,
    expect: () => [
      isA<MealDetailReady>().having((state) => state.cooking, 'cooking', isA<MealCookingSaving>()),
      isA<MealDetailReady>().having((state) => state.cooking, 'cooking', isA<MealCookingDone>()),
    ],
    verify: (_) {
      final input =
          verify(() => fridge.updateItem(household, eggs.id, captureAny())).captured.single as FridgeItemInput;
      expect(input.quantity, 2);
      verify(() => fridge.deleteItem(household, spinach.id)).called(1);
      verify(() => meals.recordCookedMeal(household, idea.title)).called(1);
    },
  );

  blocTest<MealDetailCubit, MealDetailState>(
    'keeps the meal out of the history when the fridge cannot be updated',
    build: () {
      when(
        () => fridge.updateItem(household, any(), any()),
      ).thenReturn(TaskEither.left(const FridgeNetworkFailure()));
      return build(idea.id);
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.cook([MealDeduction(item: eggs, quantity: 4)]);
    },
    skip: 3,
    expect: () => [
      isA<MealDetailReady>().having((state) => state.cooking, 'cooking', isA<MealCookingFailed>()),
    ],
    verify: (_) => verifyNever(() => meals.recordCookedMeal(any(), any())),
  );

  blocTest<MealDetailCubit, MealDetailState>(
    'adds the meal to the week for the chosen number of people',
    build: () {
      when(() => meals.planMeal(household, any())).thenReturn(TaskEither.right(unit));
      return build(idea.id);
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.changeServings(6);
      await cubit.toggleWeek();
    },
    verify: (_) {
      final planned = verify(() => meals.planMeal(household, captureAny())).captured.single as MealIdea;
      expect(planned.servings, 6);
      expect(planned.ingredients[1].quantity, 6);
    },
  );

  blocTest<MealDetailCubit, MealDetailState>(
    'follows the week: its servings, its removal and its cooking',
    build: () {
      when(() => meals.watchWeek(household)).thenAnswer(
        (_) => Stream.value(
          right([WeekMeal(idea: idea.copyWith(servings: 2), status: WeekMealStatus.planned, addedAt: today)]),
        ),
      );
      when(() => meals.planMeal(household, any())).thenReturn(TaskEither.right(unit));
      when(() => meals.unplanMeal(household, idea.id)).thenReturn(TaskEither.right(unit));
      when(() => meals.markCooked(household, idea.id)).thenReturn(TaskEither.right(unit));
      return build(idea.id);
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      expect((cubit.state as MealDetailReady).servings, 2);
      await cubit.changeServings(3);
      await cubit.toggleWeek();
      await cubit.cook(const []);
    },
    verify: (_) {
      final planned = verify(() => meals.planMeal(household, captureAny())).captured.single as MealIdea;
      expect(planned.servings, 3);
      verify(() => meals.unplanMeal(household, idea.id)).called(1);
      verify(() => meals.markCooked(household, idea.id)).called(1);
    },
  );
}
