import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_week.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_list.dart';

final ShoppingList shoppingBoneMock = ShoppingList(
  lines: <ShoppingLine>[
    for (final int index in <int>[0, 1, 2, 3])
      ShoppingLine(
        id: ShoppingEntryId('bone-$index'),
        key: 'bone',
        name: 'Ingrédient à acheter',
        needed: none(),
        purchase: 1,
        unit: FridgeUnit.piece,
        pack: none(),
        category: index < 2 ? FridgeCategory.fruitsVegetables : FridgeCategory.dairy,
        meals: const <String>['Repas de la semaine'],
        checked: false,
        manual: false,
        addedBy: none(),
      ),
  ],
  reservations: const [],
  plannedMeals: 2,
);

const ShoppingWeek shoppingWeekBoneMock = (
  facts: (week: <WeekMeal>[], items: <FridgeItem>[], entries: <ShoppingEntry>[]),
  prices: (household: <HouseholdPrice>[], openPrices: <String, OpenPriceStats>{}),
  expenses: <Expense>[],
);
