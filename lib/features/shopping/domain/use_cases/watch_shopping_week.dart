import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/open_price_stats.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_week.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';

typedef _WeekData = (
  ((List<WeekMeal>, List<FridgeItem>), List<ShoppingEntry>),
  (List<HouseholdPrice>, List<Expense>),
);

final class WatchShoppingWeek {
  WatchShoppingWeek({ShoppingRepository? shopping, MealsRepository? meals, FridgeRepository? fridge})
    : _shopping = shopping ?? getIt.get<ShoppingRepository>(),
      _meals = meals ?? getIt.get<MealsRepository>(),
      _fridge = fridge ?? getIt.get<FridgeRepository>();

  final ShoppingRepository _shopping;
  final MealsRepository _meals;
  final FridgeRepository _fridge;

  Stream<Either<AppFailure, ShoppingWeek>> call(HouseholdId household, DateTime since) =>
      combineLatestEither(
        combineLatestEither(
          combineLatestEither(_meals.watchWeek(household), _fridge.watchItems(household)),
          _shopping.watchEntries(household),
        ),
        combineLatestEither(_shopping.watchPrices(household), _shopping.watchExpenses(household, since)),
      ).asyncMap(
        (Either<AppFailure, _WeekData> result) => result.match(
          (AppFailure failure) => Future<Either<AppFailure, ShoppingWeek>>.value(left(failure)),
          _withOpenPrices,
        ),
      );

  Future<Either<AppFailure, ShoppingWeek>> _withOpenPrices(_WeekData data) {
    final ShoppingFacts facts = (week: data.$1.$1.$1, items: data.$1.$1.$2, entries: data.$1.$2);
    return _shopping
        .openPrices(openPricesTags(shoppingList(facts).lines.map((ShoppingLine line) => line.name)))
        .map(
          (Map<String, OpenPriceStats> openPrices) => Either<AppFailure, ShoppingWeek>.right((
            facts: facts,
            prices: (household: data.$2.$1, openPrices: openPrices),
            expenses: data.$2.$2,
          )),
        )
        .run();
  }
}
