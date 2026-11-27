import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/shopping/domain/use_cases/watch_shopping_week.dart';
import 'package:mocktail/mocktail.dart';

import '../../../meals/meals_fixtures.dart';
import '../../shopping_fixtures.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

class MockMealsRepository extends Mock implements MealsRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  const household = HouseholdId('h1');

  setUpAll(registerShoppingFallbacks);

  test('gathers the week and asks Open Prices for the ingredients to buy', () async {
    final shopping = MockShoppingRepository();
    final meals = MockMealsRepository();
    final fridge = MockFridgeRepository();
    final stats = OpenPriceStats(
      tag: 'en:carrots',
      basis: PriceBasis.kilogram,
      cents: 120,
      lowCents: 55,
      highCents: 290,
      observations: 24,
      lastSeen: today,
    );
    when(() => meals.watchWeek(household)).thenAnswer(
      (_) => Stream.value(
        right([
          weekMeal('Velouté', [ingredient('Carottes', quantity: 1, unit: FridgeUnit.kilogram)]),
        ]),
      ),
    );
    when(() => fridge.watchItems(household)).thenAnswer((_) => Stream.value(right(const [])));
    when(() => shopping.watchEntries(household)).thenAnswer((_) => Stream.value(right(const [])));
    stubPricesAndExpenses(shopping, household);
    when(() => shopping.openPrices({'en:carrots': PriceBasis.kilogram})).thenReturn(Task.of({'en:carrots': stats}));

    final week = await WatchShoppingWeek(shopping: shopping, meals: meals, fridge: fridge)(household, today).first;

    expect(week.map((it) => it.prices.openPrices['en:carrots']?.cents), right<Never, double?>(120));
    expect(week.map((it) => it.facts.week.length), right<Never, int>(1));
    verify(() => shopping.watchExpenses(household, today)).called(1);
  });
}
