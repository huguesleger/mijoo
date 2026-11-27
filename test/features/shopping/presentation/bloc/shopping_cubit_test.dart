import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../meals/meals_fixtures.dart';
import '../../shopping_fixtures.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

class MockMealsRepository extends Mock implements MealsRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  const household = HouseholdId('h1');
  final salad = weekMeal('Salade de pâtes', [
    ingredient('Oeufs', quantity: 3),
    ingredient('Carottes', quantity: 300, unit: FridgeUnit.gram),
  ]);
  final eggsInFridge = fridgeItem('Oeufs', quantity: 2);
  late MockShoppingRepository shopping;
  late MockMealsRepository meals;
  late MockFridgeRepository fridge;

  setUpAll(() {
    registerFallbackValue(household);
    registerFallbackValue(const ShoppingEntryId('x'));
    registerFallbackValue(const FridgeItemId('x'));
    registerFallbackValue(eggsInFridge.input);
    registerFallbackValue(entry('x').input);
    registerFallbackValue(<ShoppingEntryId>[]);
  });

  setUp(() {
    shopping = MockShoppingRepository();
    meals = MockMealsRepository();
    fridge = MockFridgeRepository();
    when(() => meals.watchWeek(household)).thenAnswer((_) => Stream.value(right([salad])));
    when(() => fridge.watchItems(household)).thenAnswer((_) => Stream.value(right([eggsInFridge])));
    when(() => shopping.watchEntries(household)).thenAnswer(
      (_) => Stream.value(right([entry('m1', key: 'pain', name: 'Pain', manual: true, checked: true)])),
    );
    when(() => shopping.saveEntry(household, any(), any())).thenReturn(TaskEither.right(unit));
    when(() => shopping.addEntry(household, any())).thenReturn(TaskEither.right(unit));
    when(() => shopping.deleteEntries(household, any())).thenReturn(TaskEither.right(unit));
    when(() => fridge.addItem(household, any())).thenReturn(TaskEither.right(unit));
    when(() => fridge.updateItem(household, any(), any())).thenReturn(TaskEither.right(unit));
  });

  ShoppingCubit build() => ShoppingCubit(
    household: household,
    author: 'Camille',
    shopping: shopping,
    meals: meals,
    fridge: fridge,
    minimalLoading: Duration.zero,
  );

  Future<List<ShoppingLine>> lines(ShoppingCubit cubit) async {
    cubit.watch();
    await pumpEventQueue();
    return switch (cubit.state) {
      ShoppingLoaded(:final facts) => shoppingList(facts).lines,
      ShoppingLoading() || ShoppingFailed() => fail('not loaded'),
    };
  }

  test('builds the list from the week, the fridge and the entries', () async {
    final cubit = build();
    final list = await lines(cubit);
    expect(list.map((it) => it.key), ['oeuf', 'carotte', 'pain']);
    expect(list.first.needed, some(1.0));
    await cubit.close();
  });

  test('checks a line of the list', () async {
    final cubit = build();
    final eggs = (await lines(cubit)).first;
    await cubit.toggle(eggs);
    final saved =
        verify(() => shopping.saveEntry(household, eggs.id, captureAny())).captured.single as ShoppingEntryInput;
    expect(saved.checked, isTrue);
    expect(saved.key, 'oeuf');
    await cubit.close();
  });

  test('adds an article by hand, signed by its author', () async {
    final cubit = build();
    await lines(cubit);
    await cubit.add('  Sacs poubelle ');
    await cubit.add('   ');
    final added = verify(() => shopping.addEntry(household, captureAny())).captured.single as ShoppingEntryInput;
    expect(added.name, 'Sacs poubelle');
    expect(added.manual, isTrue);
    expect(added.addedBy, some('Camille'));
    await cubit.close();
  });

  test('hides a needed ingredient instead of deleting it', () async {
    final cubit = build();
    final eggs = (await lines(cubit)).first;
    await cubit.remove(eggs);
    final saved =
        verify(() => shopping.saveEntry(household, eggs.id, captureAny())).captured.single as ShoppingEntryInput;
    expect(saved.dismissed, isTrue);
    verifyNever(() => shopping.deleteEntries(any(), any()));
    await cubit.close();
  });

  test('stores the bought ingredients in the fridge and clears them from the list', () async {
    final cubit = build();
    final list = await lines(cubit);
    final eggs = list.first;
    final bread = list.last;
    await cubit.store([(line: eggs, quantity: 6)], [eggs, bread]);
    final merged =
        verify(() => fridge.updateItem(household, eggsInFridge.id, captureAny())).captured.single as FridgeItemInput;
    expect(merged.quantity, 8);
    final deleted =
        verify(() => shopping.deleteEntries(household, captureAny())).captured.single as List<ShoppingEntryId>;
    expect(deleted, [eggs.id, bread.id]);
    verifyNever(() => fridge.addItem(any(), any()));
    await cubit.close();
  });

  test('adds a new item to the fridge when it holds none of it', () async {
    final cubit = build();
    final carrots = (await lines(cubit))[1];
    await cubit.store([(line: carrots, quantity: 1500)], [carrots]);
    final added = verify(() => fridge.addItem(household, captureAny())).captured.single as FridgeItemInput;
    expect(added.quantity, 1.5);
    expect(added.unit, FridgeUnit.kilogram);
    expect(added.category, FridgeCategory.other);
    await cubit.close();
  });
}
