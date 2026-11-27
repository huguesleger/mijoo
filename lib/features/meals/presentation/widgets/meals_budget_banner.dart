import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';

class MealsBudgetBanner extends StatelessWidget {
  const MealsBudgetBanner({required this.remainingCents, required this.overBudget, super.key});

  final double remainingCents;
  final int overBudget;

  @override
  Widget build(BuildContext context) => MjMessageView(
    icon: some(LucideIcons.wallet),
    message: switch ((remainingCents > 0, overBudget)) {
      (true, 1) => t.meals.budgetLeftSingle(amount: euros(remainingCents)),
      (true, final int count) => t.meals.budgetLeftSeveral(amount: euros(remainingCents), count: count),
      (false, 1) => t.meals.budgetSpentSingle,
      (false, final int count) => t.meals.budgetSpentSeveral(count: count),
    },
  );
}
