import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';

import '../meals/meals_fixtures.dart';

WeekMeal weekMeal(
  String title,
  List<MealIngredient> ingredients, {
  WeekMealStatus status = WeekMealStatus.planned,
  int order = 0,
}) => WeekMeal(
  idea: mealIdea(title: title, ingredients: ingredients),
  status: status,
  addedAt: DateTime(2026, 11, 27, 10, order),
);

ShoppingEntry entry(
  String id, {
  String key = '',
  String name = 'Article',
  Option<double> quantity = const None(),
  FridgeUnit unit = FridgeUnit.piece,
  bool checked = false,
  bool dismissed = false,
  bool manual = false,
}) => ShoppingEntry(
  id: ShoppingEntryId(id),
  input: ShoppingEntryInput(
    key: key,
    name: name,
    quantity: quantity,
    unit: unit,
    category: none(),
    checked: checked,
    dismissed: dismissed,
    manual: manual,
    addedBy: manual ? some('Camille') : none(),
  ),
);

void registerShoppingFallbacks() {
  registerFallbackValue(DateTime(2000));
  registerFallbackValue(<String, PriceBasis>{});
}

void stubPricesAndExpenses(ShoppingRepository shopping, HouseholdId household, {List<Expense> expenses = const []}) {
  when(() => shopping.watchPrices(household)).thenAnswer((_) => Stream.value(right(const [])));
  when(() => shopping.watchExpenses(household, any())).thenAnswer((_) => Stream.value(right(expenses)));
  when(() => shopping.openPrices(any())).thenReturn(Task.of(const {}));
}
