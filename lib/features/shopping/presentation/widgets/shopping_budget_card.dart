import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/week_budget.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_budget_bar.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_budget_figure.dart';

class ShoppingBudgetCard extends StatelessWidget {
  const ShoppingBudgetCard({required this.budget, required this.onAddExpense, super.key});

  final WeekBudget budget;
  final VoidCallback onAddExpense;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(MjSpacing.medium),
    decoration: BoxDecoration(
      color: MjColors.onInk,
      borderRadius: MjRadius.card,
      border: Border.all(color: MjColors.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                t.shopping.week(date: shortDate(budget.start)),
                style: MjTextStyles.cardTitle.copyWith(fontSize: 17),
              ),
            ),
            MjChoiceChip(
              label: t.shopping.expense,
              icon: some(LucideIcons.plus),
              selected: false,
              onTap: onAddExpense,
            ),
          ],
        ),
        const SizedBox(height: MjSpacing.fieldGap),
        ShoppingBudgetBar(budget: budget),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ShoppingBudgetFigure(
                label: t.shopping.spent,
                value: euros(budget.spentCents.toDouble()),
                tone: some(MjTone.green),
              ),
            ),
            Expanded(
              child: ShoppingBudgetFigure(
                label: t.shopping.planned,
                value: t.shopping.approx(amount: euros(budget.basket.cents)),
                detail: (budget.basket.highCents - budget.basket.lowCents).abs() < 1
                    ? none()
                    : some(
                        t.shopping.plannedRange(
                          low: euros(budget.basket.lowCents),
                          high: euros(budget.basket.highCents),
                        ),
                      ),
                tone: some(MjTone.lavender),
              ),
            ),
            Expanded(
              child: budget.budgetCents.match(
                () => ShoppingBudgetFigure(
                  label: t.shopping.noBudget,
                  value: '—',
                  detail: some(t.shopping.noBudgetDetail),
                  alignEnd: true,
                ),
                (int total) => budget.remainingCents.match(
                  () => const SizedBox.shrink(),
                  (double remaining) => ShoppingBudgetFigure(
                    label: remaining >= 0
                        ? t.shopping.remaining(budget: euros(total.toDouble()))
                        : t.shopping.overBudget(budget: euros(total.toDouble())),
                    value: euros(remaining.abs()),
                    valueTone: some(remaining >= 0 ? MjTone.green : MjTone.peony),
                    alignEnd: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
