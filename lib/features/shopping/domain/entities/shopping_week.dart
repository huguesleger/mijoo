import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/price_book.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';

typedef ShoppingWeek = ({ShoppingFacts facts, PriceBook prices, List<Expense> expenses});
