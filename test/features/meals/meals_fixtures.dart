import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_difficulty.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/domain/entities/meal_step.dart';

final DateTime today = DateTime(2026, 11, 27);

FridgeItem fridgeItem(
  String name, {
  double quantity = 1,
  FridgeUnit unit = FridgeUnit.piece,
  Option<DateTime> bestBefore = const None(),
}) => FridgeItem(
  id: FridgeItemId(name),
  name: name,
  quantity: quantity,
  unit: unit,
  category: FridgeCategory.other,
  bestBefore: bestBefore,
);

MealIngredient ingredient(
  String name, {
  double quantity = 1,
  FridgeUnit unit = FridgeUnit.piece,
  Option<String> substitute = const None(),
}) => MealIngredient(
  name: name,
  quantity: quantity,
  unit: unit,
  category: FridgeCategory.other,
  substitute: substitute,
);

MealIdea mealIdea({
  String title = 'Gratin d’épinards',
  int minutes = 25,
  List<MealIngredient>? ingredients,
}) => MealIdea(
  id: MealIdeaId(title),
  title: title,
  description: 'Un plat fondant.',
  prepMinutes: 10,
  cookMinutes: minutes - 10,
  servings: 4,
  kind: MealKind.oven,
  difficulty: MealDifficulty.easy,
  equipment: const <String>['Poêle'],
  photoQueries: const <String>['spinach gratin', 'gratin', 'spinach'],
  photo: none(),
  ingredients:
      ingredients ??
      <MealIngredient>[
        ingredient('Épinards', unit: FridgeUnit.pack),
        ingredient('Œufs', quantity: 4),
        ingredient('Gruyère râpé', quantity: 100, unit: FridgeUnit.gram),
      ],
  steps: <MealStep>[MealStep(text: 'Fais revenir les épinards.', minutes: some(3))],
);

const HouseholdProfile profile = HouseholdProfile(
  adults: 2,
  children: 2,
  likes: <String>['pasta'],
  exclusions: <String>['pork'],
  allergies: <String>['peanuts'],
  maxPrepMinutes: 30,
  weeklyBudgetCents: None(),
  location: None(),
);
