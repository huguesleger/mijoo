import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';

class ShoppingExpenseRow extends StatelessWidget {
  const ShoppingExpenseRow({required this.expense, required this.onDelete, super.key});

  final Expense expense;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: MjSpacing.small),
    child: Row(
      children: <Widget>[
        const MjIconTile(icon: LucideIcons.shoppingBag, tone: MjTone.green, size: 38),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(expense.input.store.getOrElse(() => t.shopping.expenseDefault), style: MjTextStyles.itemTitle),
              Text(
                expense.input.addedBy.match(
                  () => dayDate(expense.input.date),
                  (String name) => t.shopping.expenseBy(date: dayDate(expense.input.date), name: name),
                ),
                style: MjTextStyles.detail.copyWith(fontSize: 11.5),
              ),
            ],
          ),
        ),
        Text(preciseEuros(expense.input.amountCents.toDouble()), style: MjTextStyles.cardTitle.copyWith(fontSize: 15)),
        MjStepButton(
          icon: LucideIcons.trash2,
          tooltip: t.shopping.deleteExpense(amount: preciseEuros(expense.input.amountCents.toDouble())),
          onPressed: onDelete,
        ),
      ],
    ),
  );
}
