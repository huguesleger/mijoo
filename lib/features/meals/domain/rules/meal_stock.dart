import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';
import 'package:mijoo/features/meals/domain/entities/ingredient_availability.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/rules/meal_units.dart';
import 'package:mijoo/features/meals/domain/rules/meal_words.dart';

typedef MealCoverage = ({int inFridge, int total});

bool sameIngredient(String first, String second) {
  final Set<String> a = mealWords(first);
  final Set<String> b = mealWords(second);
  return a.isNotEmpty && b.isNotEmpty && (a.containsAll(b) || b.containsAll(a));
}

Option<FridgeItem> stockFor(MealIngredient ingredient, List<FridgeItem> items) => Option<FridgeItem>.fromNullable(
  (items.where((FridgeItem item) => sameIngredient(ingredient.name, item.name)).toList()..sort(_soonestFirst))
      .firstOrNull,
);

MealCoverage mealCoverage(MealIdea idea, List<FridgeItem> items) => (
  inFridge: idea.ingredients.where((MealIngredient ingredient) => stockFor(ingredient, items).isSome()).length,
  total: idea.ingredients.length,
);

IngredientAvailability ingredientAvailability(MealIngredient ingredient, List<FridgeItem> items) =>
    stockFor(ingredient, items).match(
      () => const ToBuy(),
      (FridgeItem item) => convertQuantity(item.quantity, item.unit, ingredient.unit)
          .filter((double inStock) => inStock + 0.0001 < ingredient.quantity)
          .match<IngredientAvailability>(
            () => const InFridge(),
            (double inStock) => NotEnoughInFridge(ingredient.quantity - inStock),
          ),
    );

List<MealIngredient> missingIngredients(MealIdea idea, List<FridgeItem> items) =>
    idea.ingredients.where((MealIngredient ingredient) => stockFor(ingredient, items).isNone()).toList();

List<FridgeItem> finishFirstUsed(MealIdea idea, List<FridgeItem> items, DateTime today) {
  final List<FridgeItem> toFinish = itemsToFinishFirst(
    items,
    today,
  ).where((FridgeItem item) => fridgeFreshness(item, today) != FridgeFreshness.expired).toList();
  return <FridgeItem>{
    for (final MealIngredient ingredient in idea.ingredients)
      ...stockFor(ingredient, toFinish).match(() => const <FridgeItem>[], (FridgeItem item) => <FridgeItem>[item]),
  }.toList();
}

int _soonestFirst(FridgeItem a, FridgeItem b) => switch ((a.bestBefore, b.bestBefore)) {
  (Some(value: final DateTime first), Some(value: final DateTime second)) => first.compareTo(second),
  (Some(), None()) => -1,
  (None(), Some()) => 1,
  (None(), None()) => 0,
};
