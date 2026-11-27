import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/price_book.dart';
import 'package:mijoo/features/shopping/domain/entities/price_reliability.dart';
import 'package:mijoo/features/shopping/domain/entities/price_source.dart';
import 'package:mijoo/features/shopping/domain/rules/price_catalog.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';

import '../../../meals/meals_fixtures.dart';
import '../../shopping_fixtures.dart';

void main() {
  final carrots = OpenPriceStats(
    tag: 'en:carrots',
    basis: PriceBasis.kilogram,
    cents: 120,
    lowCents: 55,
    highCents: 290,
    observations: 24,
    lastSeen: today.subtract(const Duration(days: 10)),
  );
  const PriceBook empty = (household: [], openPrices: {});

  test('finds the most precise catalog entry', () {
    expect(catalogPrice('Pommes de terre').map((it) => it.openPricesTag), some(some('en:potatoes')));
    expect(catalogPrice('Pommes golden').map((it) => it.cents), some(300.0));
    expect(catalogPrice('Tomates concassées').map((it) => it.cents), some(350.0));
    expect(catalogPrice('Pois chiches').map((it) => it.cents), some(300.0));
    expect(catalogPrice('Sacs poubelle'), isA<None>());
  });

  test('prefers the household price, then Open Prices, then the catalog', () {
    final PriceBook book = (
      household: [const HouseholdPrice(key: 'oeuf', name: 'Œufs', cents: 35, basis: PriceBasis.piece)],
      openPrices: {'en:carrots': carrots},
    );
    expect(referencePrice('Œufs', book).map((it) => (it.source, it.cents)), some((PriceSource.household, 35.0)));
    expect(referencePrice('Carottes', book).map((it) => (it.source, it.cents)), some((PriceSource.openPrices, 120.0)));
    expect(referencePrice('Carottes', empty).map((it) => (it.source, it.cents)), some((PriceSource.catalog, 150.0)));
  });

  test('ignores Open Prices with too few observations', () {
    final PriceBook book = (
      household: [],
      openPrices: {
        'en:carrots': OpenPriceStats(
          tag: 'en:carrots',
          basis: PriceBasis.kilogram,
          cents: 999,
          lowCents: 999,
          highCents: 999,
          observations: 2,
          lastSeen: today,
        ),
      },
    );
    expect(referencePrice('Carottes', book).map((it) => it.source), some(PriceSource.catalog));
  });

  test('rates how much a price can be trusted', () {
    final PriceBook book = (household: [], openPrices: {'en:carrots': carrots});
    expect(referencePrice('Carottes', book).map((it) => priceReliability(it, today)), some(PriceReliability.high));
    expect(referencePrice('Riz', book).map((it) => priceReliability(it, today)), some(PriceReliability.low));
    expect(
      referencePrice('Carottes', book).map((it) => priceReliability(it, today.add(const Duration(days: 300)))),
      some(PriceReliability.medium),
    );
  });

  test('costs a quantity in grams, millilitres or pieces', () {
    expect(
      costOf('Carottes', 800, FridgeUnit.gram, empty).map((it) => it.cents).getOrElse(() => -1),
      closeTo(120, 0.001),
    );
    expect(costOf('Lait', 1.5, FridgeUnit.liter, empty).map((it) => it.cents).getOrElse(() => -1), closeTo(165, 0.001));
    expect(costOf('Œufs', 6, FridgeUnit.piece, empty).map((it) => it.cents).getOrElse(() => -1), closeTo(180, 0.001));
    expect(costOf('Œufs', 300, FridgeUnit.gram, empty), isA<None>());
    expect(costOf('Sacs poubelle', 1, FridgeUnit.piece, empty), isA<None>());
  });

  test('estimates the basket of what is still to buy', () {
    final lines = shoppingList((
      week: [
        weekMeal('Salade', [
          ingredient('Carottes', quantity: 1, unit: FridgeUnit.kilogram),
          ingredient('Œufs', quantity: 6),
        ]),
      ],
      items: [],
      entries: [
        entry('m1', key: 'sac poubelle', name: 'Sacs poubelle', quantity: some(1), manual: true),
        entry(needEntryId('oeuf', FridgeUnit.piece).value, key: 'oeuf', checked: true),
      ],
    )).lines;
    final estimate = basketEstimate(lines, empty);
    expect(estimate.cents, closeTo(150, 0.001));
    expect(estimate.lowCents, closeTo(105, 0.001));
    expect(estimate.costs.length, 2);
    expect(estimate.unpriced.single.value, 'm1');
  });

  test('asks Open Prices only for the ingredients it knows', () {
    expect(openPricesTags(['Carottes', 'Œufs', 'Tomates cerises']), {
      'en:carrots': PriceBasis.kilogram,
      'en:tomatoes': PriceBasis.kilogram,
    });
  });

  test('prices pieces sold by the kilogram with their usual weight', () {
    expect(
      costOf('Fromage Coulommiers', 1, FridgeUnit.piece, empty).map((it) => it.cents).getOrElse(() => -1),
      closeTo(300, 0.001),
    );
    expect(
      costOf('Oignons', 2, FridgeUnit.piece, empty).map((it) => it.cents).getOrElse(() => -1),
      closeTo(48, 0.001),
    );
    expect(costOf('Riz', 1, FridgeUnit.piece, empty), isA<None>());
  });

  test('suggests a sensible unit and aisle for an article added by hand', () {
    expect(manualDefaults('Citron'), (
      quantity: 1.0,
      unit: FridgeUnit.piece,
      category: some(FridgeCategory.fruitsVegetables),
    ));
    expect(manualDefaults('Riz basmati'), (
      quantity: 500.0,
      unit: FridgeUnit.gram,
      category: some(FridgeCategory.grocery),
    ));
    expect(manualDefaults('Lait'), (quantity: 1.0, unit: FridgeUnit.liter, category: some(FridgeCategory.dairy)));
    expect(manualDefaults('Sacs poubelle'), (quantity: 1.0, unit: FridgeUnit.piece, category: none<FridgeCategory>()));
  });
}
