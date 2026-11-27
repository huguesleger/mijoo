import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/week_budget.dart';

class ShoppingBudgetBar extends StatelessWidget {
  const ShoppingBudgetBar({required this.budget, super.key});

  final WeekBudget budget;

  @override
  Widget build(BuildContext context) {
    final double spent = budget.spentCents.toDouble();
    final double planned = budget.basket.cents;
    final double total = max(budget.budgetCents.match(() => 0.0, (int cents) => cents.toDouble()), spent + planned);
    final int spentFlex = total == 0 ? 0 : (spent / total * 1000).round();
    final int plannedFlex = total == 0 ? 0 : (planned / total * 1000).round();
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        height: 12,
        color: MjColors.field,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (spentFlex > 0)
              Expanded(
                flex: spentFlex,
                child: ColoredBox(color: MjTone.green.foreground),
              ),
            if (plannedFlex > 0)
              Expanded(
                flex: plannedFlex,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[MjColors.lavenderStrong, MjColors.peonyStrong]),
                  ),
                ),
              ),
            if (1000 - spentFlex - plannedFlex > 0) Spacer(flex: 1000 - spentFlex - plannedFlex),
          ],
        ),
      ),
    );
  }
}
