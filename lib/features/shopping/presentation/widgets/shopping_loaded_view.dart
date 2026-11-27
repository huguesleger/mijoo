import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_list.dart';
import 'package:mijoo/features/shopping/domain/entities/week_budget.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/shopping_navigation.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_budget_card.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_empty_view.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_reserved_section.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_section.dart';

class ShoppingLoadedView extends StatelessWidget {
  const ShoppingLoadedView({required this.list, required this.budget, required this.state, super.key});

  final ShoppingList list;
  final WeekBudget budget;
  final ShoppingLoaded state;

  @override
  Widget build(BuildContext context) {
    final List<ShoppingLine> unpriced = list.lines
        .where((ShoppingLine line) => budget.basket.unpriced.contains(line.id))
        .toList();
    final List<ShoppingLine> priced = list.lines
        .where((ShoppingLine line) => !budget.basket.unpriced.contains(line.id))
        .toList();
    final List<ShoppingLine> manual = priced.where((ShoppingLine line) => line.manual).toList();
    String subtotal(List<ShoppingLine> lines) => t.shopping.approx(
      amount: euros(
        lines.fold(0, (double total, ShoppingLine line) => total + (budget.basket.costs[line.id]?.cents ?? 0)),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: MjSpacing.small,
      children: <Widget>[
        ShoppingBudgetCard(budget: budget, onAddExpense: () => openShoppingExpenseSheet(context, state)),
        MjAddField(hint: t.shopping.addHint, addLabel: t.shopping.add, onAdd: context.read<ShoppingCubit>().add),
        ...state.writeFailure.match(() => const <Widget>[], (failure) => <Widget>[FailureView(failure: failure)]),
        if (list.lines.isEmpty && list.reservations.isEmpty) const ShoppingEmptyView(),
        for (final FridgeCategory category in FridgeCategory.values)
          if (priced.where((ShoppingLine line) => !line.manual && line.category == category).toList()
              case final List<ShoppingLine> lines when lines.isNotEmpty)
            ShoppingSection(
              title: t.fridge.categories[category.name] ?? category.name,
              icon: fridgeCategoryIcon(category),
              tone: fridgeCategoryTone(category),
              lines: lines,
              costs: budget.basket.costs,
              today: state.today,
              trailing: subtotal(lines),
            ),
        if (manual.isNotEmpty)
          ShoppingSection(
            title: t.shopping.manual,
            icon: LucideIcons.pencil,
            tone: MjTone.neutral,
            lines: manual,
            costs: budget.basket.costs,
            today: state.today,
            trailing: subtotal(manual),
          ),
        if (unpriced.isNotEmpty)
          ShoppingSection(
            title: t.shopping.unpriced,
            icon: LucideIcons.circleHelp,
            tone: MjTone.neutral,
            lines: unpriced,
            costs: budget.basket.costs,
            today: state.today,
            trailing: '${unpriced.length}',
          ),
        if (list.reservations.isNotEmpty) ShoppingReservedSection(reservations: list.reservations),
      ],
    );
  }
}
