import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/shopping/domain/entities/basket_estimate.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/price_book.dart';
import 'package:mijoo/features/shopping/domain/entities/price_reliability.dart';
import 'package:mijoo/features/shopping/domain/entities/price_source.dart';
import 'package:mijoo/features/shopping/domain/entities/reference_price.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/price_catalog.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_units.dart';

const int minOpenPricesObservations = 3;
const int reliableOpenPricesObservations = 10;
const Duration freshPrices = Duration(days: 120);
const double catalogLowFactor = 0.7;
const double catalogHighFactor = 1.4;

Map<String, PriceBasis> openPricesTags(Iterable<String> names) => <String, PriceBasis>{
  for (final String name in names)
    if (catalogPrice(name).toNullable() case final CatalogPrice entry)
      if (entry.openPricesTag.toNullable() case final String tag) tag: entry.basis,
};

PriceBasis basisFor(FridgeUnit unit) => switch (toBaseUnit(1, unit).unit) {
  FridgeUnit.gram || FridgeUnit.kilogram => PriceBasis.kilogram,
  FridgeUnit.milliliter || FridgeUnit.liter => PriceBasis.liter,
  FridgeUnit.piece || FridgeUnit.pack => PriceBasis.piece,
};

Option<ReferencePrice> referencePrice(String name, PriceBook book) {
  final String key = ingredientKey(name);
  return Option<HouseholdPrice>.fromNullable(
        book.household.where((HouseholdPrice price) => price.key == key).firstOrNull,
      )
      .map(
        (HouseholdPrice price) => ReferencePrice(
          cents: price.cents,
          lowCents: price.cents,
          highCents: price.cents,
          basis: price.basis,
          source: PriceSource.household,
          observations: 1,
          lastSeen: none(),
        ),
      )
      .alt(() => catalogPrice(name).flatMap((CatalogPrice entry) => _fromCatalog(entry, book)));
}

Option<ReferencePrice> _fromCatalog(CatalogPrice entry, PriceBook book) => entry.openPricesTag
    .flatMap((String tag) => Option<OpenPriceStats>.fromNullable(book.openPrices[tag]))
    .filter(
      (OpenPriceStats stats) => stats.observations >= minOpenPricesObservations && stats.basis == entry.basis,
    )
    .map(
      (OpenPriceStats stats) => ReferencePrice(
        cents: stats.cents,
        lowCents: stats.lowCents,
        highCents: stats.highCents,
        basis: stats.basis,
        source: PriceSource.openPrices,
        observations: stats.observations,
        lastSeen: some(stats.lastSeen),
      ),
    )
    .alt(
      () => some(
        ReferencePrice(
          cents: entry.cents,
          lowCents: entry.cents * catalogLowFactor,
          highCents: entry.cents * catalogHighFactor,
          basis: entry.basis,
          source: PriceSource.catalog,
          observations: 0,
          lastSeen: none(),
        ),
      ),
    );

PriceReliability priceReliability(ReferencePrice price, DateTime today) => switch (price.source) {
  PriceSource.household => PriceReliability.high,
  PriceSource.catalog => PriceReliability.low,
  PriceSource.openPrices =>
    price.observations >= reliableOpenPricesObservations &&
            price.lastSeen.match(() => false, (DateTime seen) => today.difference(seen) <= freshPrices)
        ? PriceReliability.high
        : PriceReliability.medium,
};

Option<double> quantityInBasis(
  double quantity,
  FridgeUnit unit,
  PriceBasis basis, {
  Option<double> pieceGrams = const None(),
}) {
  final BaseQuantity base = toBaseUnit(quantity, unit);
  return switch ((base.unit, basis)) {
    (FridgeUnit.gram, PriceBasis.kilogram) || (FridgeUnit.milliliter, PriceBasis.liter) => some(base.quantity / 1000),
    (FridgeUnit.piece || FridgeUnit.pack, PriceBasis.piece) => some(base.quantity),
    (FridgeUnit.piece, PriceBasis.kilogram) => pieceGrams.map((double grams) => base.quantity * grams / 1000),
    _ => none(),
  };
}

Option<LineCost> costOf(String name, double quantity, FridgeUnit unit, PriceBook book) =>
    referencePrice(name, book).flatMap(
      (ReferencePrice price) =>
          quantityInBasis(
            quantity,
            unit,
            price.basis,
            pieceGrams: catalogPrice(name).flatMap((CatalogPrice entry) => entry.pieceGrams),
          ).map(
            (double amount) => LineCost(
              price: price,
              cents: amount * price.cents,
              lowCents: amount * price.lowCents,
              highCents: amount * price.highCents,
            ),
          ),
    );

BasketEstimate basketEstimate(List<ShoppingLine> lines, PriceBook book) {
  final List<ShoppingLine> toBuy = lines.where((ShoppingLine line) => !line.checked).toList();
  final Map<ShoppingEntryId, LineCost> costs = <ShoppingEntryId, LineCost>{
    for (final ShoppingLine line in lines)
      if (costOf(line.name, line.purchase, line.unit, book).toNullable() case final LineCost cost) line.id: cost,
  };
  final Iterable<LineCost> planned = <LineCost>[
    for (final ShoppingLine line in toBuy)
      if (costs[line.id] case final LineCost cost) cost,
  ];
  return BasketEstimate(
    cents: planned.fold(0, (double total, LineCost cost) => total + cost.cents),
    lowCents: planned.fold(0, (double total, LineCost cost) => total + cost.lowCents),
    highCents: planned.fold(0, (double total, LineCost cost) => total + cost.highCents),
    costs: costs,
    unpriced: <ShoppingEntryId>{
      for (final ShoppingLine line in lines)
        if (!costs.containsKey(line.id)) line.id,
    },
  );
}

typedef ManualDefaults = ({double quantity, FridgeUnit unit, Option<FridgeCategory> category});

ManualDefaults manualDefaults(String name) => catalogPrice(name).match(
  () => (quantity: 1, unit: FridgeUnit.piece, category: none()),
  (CatalogPrice entry) => switch ((entry.basis, entry.pieceGrams)) {
    (PriceBasis.kilogram, None()) => (quantity: 500, unit: FridgeUnit.gram, category: some(entry.category)),
    (PriceBasis.liter, _) => (quantity: 1, unit: FridgeUnit.liter, category: some(entry.category)),
    (PriceBasis.kilogram, Some()) || (PriceBasis.piece, _) => (
      quantity: 1,
      unit: FridgeUnit.piece,
      category: some(entry.category),
    ),
  },
);
