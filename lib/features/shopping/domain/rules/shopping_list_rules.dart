import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';
import 'package:mijoo/features/meals/domain/rules/meal_units.dart';
import 'package:mijoo/features/meals/domain/rules/meal_words.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_list.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_reservation.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_packs.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_units.dart';

typedef ShoppingFacts = ({List<WeekMeal> week, List<FridgeItem> items, List<ShoppingEntry> entries});

typedef _Need = ({String name, double quantity, FridgeUnit unit, FridgeCategory category, List<String> meals});

String ingredientKey(String name) => (mealWords(name).toList()..sort()).join(' ');

ShoppingEntryId needEntryId(String key, FridgeUnit unit) =>
    ShoppingEntryId('need-${key.replaceAll(RegExp('[^a-z0-9]+'), '-')}-${unit.name}');

ShoppingList shoppingList(ShoppingFacts facts) {
  final List<WeekMeal> planned = facts.week.where((WeekMeal meal) => meal.status == WeekMealStatus.planned).toList()
    ..sort((WeekMeal a, WeekMeal b) => a.addedAt.compareTo(b.addedAt));
  final Map<FridgeItemId, double> stockLeft = <FridgeItemId, double>{
    for (final FridgeItem item in facts.items) item.id: item.quantity,
  };
  final Map<FridgeItemId, ShoppingReservation> reservations = <FridgeItemId, ShoppingReservation>{};
  final Map<String, _Need> needs = <String, _Need>{};

  for (final WeekMeal meal in planned) {
    for (final MealIngredient ingredient in meal.idea.ingredients) {
      double missing = ingredient.quantity;
      for (final FridgeItem item in _matches(ingredient, facts.items)) {
        final double left = stockLeft[item.id] ?? 0;
        if (missing <= 0 || left <= 0) continue;
        final Option<double> available = convertQuantity(left, item.unit, ingredient.unit);
        final double taken = available.match(() => missing, (double inStock) => min(inStock, missing));
        final double takenFromItem = available.match(
          () => left,
          (_) => convertQuantity(taken, ingredient.unit, item.unit).getOrElse(() => left),
        );
        stockLeft[item.id] = left - takenFromItem;
        missing -= taken;
        reservations[item.id] = ShoppingReservation(
          item: item,
          quantity: (reservations[item.id]?.quantity ?? 0) + takenFromItem,
          meals: <String>{...?reservations[item.id]?.meals, meal.idea.title}.toList(),
        );
      }
      if (missing > 0.0001) {
        final BaseQuantity base = toBaseUnit(missing, ingredient.unit);
        final String key = '${ingredientKey(ingredient.name)}|${base.unit.name}';
        final _Need? previous = needs[key];
        needs[key] = (
          name: previous?.name ?? ingredient.name,
          quantity: (previous?.quantity ?? 0) + base.quantity,
          unit: base.unit,
          category: previous?.category ?? ingredient.category,
          meals: <String>{...?previous?.meals, meal.idea.title}.toList(),
        );
      }
    }
  }

  final Map<ShoppingEntryId, ShoppingEntry> entries = <ShoppingEntryId, ShoppingEntry>{
    for (final ShoppingEntry entry in facts.entries) entry.id: entry,
  };
  return ShoppingList(
    lines: <ShoppingLine>[
      for (final _Need need in needs.values)
        if (!_dismissed(need, entries)) _needLine(need, entries),
      for (final ShoppingEntry entry in facts.entries)
        if (entry.input.manual) _manualLine(entry),
    ],
    reservations: reservations.values.toList(),
    plannedMeals: planned.length,
  );
}

ShoppingLine _needLine(_Need need, Map<ShoppingEntryId, ShoppingEntry> entries) {
  final String key = ingredientKey(need.name);
  final ShoppingEntryId id = needEntryId(key, need.unit);
  final Option<ShoppingEntryInput> entry = Option<ShoppingEntry>.fromNullable(entries[id]).map(
    (ShoppingEntry entry) => entry.input,
  );
  final Option<ShoppingPack> pack = packFor(need.name, need.unit);
  return ShoppingLine(
    id: id,
    key: key,
    name: need.name,
    needed: some(need.quantity),
    purchase: entry
        .flatMap((ShoppingEntryInput input) => input.quantity)
        .getOrElse(
          () => packedQuantity(need.quantity, pack),
        ),
    unit: need.unit,
    pack: pack,
    category: entry.flatMap((ShoppingEntryInput input) => input.category).getOrElse(() => need.category),
    meals: need.meals,
    checked: entry.match(() => false, (ShoppingEntryInput input) => input.checked),
    manual: false,
    addedBy: none(),
  );
}

bool _dismissed(_Need need, Map<ShoppingEntryId, ShoppingEntry> entries) =>
    entries[needEntryId(ingredientKey(need.name), need.unit)]?.input.dismissed ?? false;

ShoppingLine _manualLine(ShoppingEntry entry) => ShoppingLine(
  id: entry.id,
  key: entry.input.key,
  name: entry.input.name,
  needed: none(),
  purchase: entry.input.quantity.getOrElse(() => 1),
  unit: entry.input.unit,
  pack: none(),
  category: entry.input.category.getOrElse(() => FridgeCategory.other),
  meals: const <String>[],
  checked: entry.input.checked,
  manual: true,
  addedBy: entry.input.addedBy,
);

List<FridgeItem> _matches(MealIngredient ingredient, List<FridgeItem> items) => <FridgeItem>[
  ...stockFor(ingredient, items).match(() => const <FridgeItem>[], (FridgeItem first) => <FridgeItem>[first]),
  ...items.where(
    (FridgeItem item) =>
        sameIngredient(ingredient.name, item.name) && stockFor(ingredient, items).toNullable()?.id != item.id,
  ),
];

ShoppingEntryInput lineEntry(
  ShoppingLine line, {
  bool? checked,
  bool dismissed = false,
  double? quantity,
  FridgeCategory? category,
}) => ShoppingEntryInput(
  key: line.key,
  name: line.name,
  quantity: switch ((quantity, line.manual)) {
    (final double value?, _) => some(value),
    (null, true) => some(line.purchase),
    (null, false) => none(),
  },
  unit: line.unit,
  category: switch ((category, line.manual)) {
    (final FridgeCategory value?, _) => some(value),
    (null, true) => some(line.category),
    (null, false) => none(),
  },
  checked: checked ?? line.checked,
  dismissed: dismissed,
  manual: line.manual,
  addedBy: line.addedBy,
);
