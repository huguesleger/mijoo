import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option, none, some;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/rules/household_inputs.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/week_budget.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_expense_row.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_sheet_result.dart';

class ShoppingExpenseSheet extends StatefulWidget {
  const ShoppingExpenseSheet({required this.expenses, required this.budget, required this.today, super.key});

  final List<Expense> expenses;
  final WeekBudget budget;
  final DateTime today;

  @override
  State<ShoppingExpenseSheet> createState() => _ShoppingExpenseSheetState();
}

class _ShoppingExpenseSheetState extends State<ShoppingExpenseSheet> {
  String _amount = '';
  String _store = '';
  late DateTime _date = widget.today;

  Option<int> get _cents =>
      parseWeeklyBudgetCents(_amount).flatMap((Option<int> cents) => cents).filter((int cents) => cents > 0);

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: widget.budget.start.subtract(const Duration(days: 7)),
      lastDate: widget.today,
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: t.shopping.expenseTitle,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: MjSpacing.fieldGap,
        children: <Widget>[
          MjTextField(
            label: t.shopping.amount,
            hint: t.shopping.amountHint,
            icon: LucideIcons.wallet,
            initialValue: '',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            suffixText: some('€'),
            error: _amount.trim().isEmpty || _cents.isSome() ? none() : some(t.shopping.amountInvalid),
            onChanged: (String amount) => setState(() => _amount = amount),
          ),
          MjListCard(
            onTap: _pickDate,
            child: Row(
              children: <Widget>[
                const Icon(LucideIcons.calendar, color: MjColors.lavenderStrong),
                const SizedBox(width: MjSpacing.fieldGap),
                Expanded(child: Text(t.shopping.date, style: MjTextStyles.fieldLabel)),
                Text(
                  DateUtils.isSameDay(_date, widget.today) ? t.shopping.today : dayDate(_date),
                  style: MjTextStyles.itemTitle,
                ),
              ],
            ),
          ),
          MjTextField(
            label: t.shopping.store,
            hint: t.shopping.storeHint,
            icon: LucideIcons.store,
            initialValue: '',
            onChanged: (String store) => setState(() => _store = store),
          ),
          FilledButton(
            onPressed: _cents.match(
              () => null,
              (int cents) =>
                  () => Navigator.of(context).pop(
                    ShoppingExpenseAdded(
                      amountCents: cents,
                      date: _date,
                      store: _store.trim().isEmpty ? none() : some(_store.trim()),
                    ),
                  ),
            ),
            child: Text(t.shopping.addExpense),
          ),
          const SizedBox(height: MjSpacing.small),
          MjSectionTitle(
            title: t.shopping.thisWeek,
            trailing: some(
              Text(
                widget.budget.budgetCents.match(
                  () => t.shopping.weekSpentNoBudget(spent: euros(widget.budget.spentCents.toDouble())),
                  (int budget) => t.shopping.weekSpent(
                    spent: euros(widget.budget.spentCents.toDouble()),
                    budget: euros(budget.toDouble()),
                  ),
                ),
                style: MjTextStyles.detail,
              ),
            ),
          ),
          if (widget.expenses.isEmpty)
            MjMessageView(message: t.shopping.noExpense)
          else
            MjListCard(
              child: Column(
                children: <Widget>[
                  for (final Expense expense in widget.expenses)
                    ShoppingExpenseRow(
                      expense: expense,
                      onDelete: () => Navigator.of(context).pop(ShoppingExpenseDeleted(expense.id)),
                    ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
